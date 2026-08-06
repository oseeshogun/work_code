import 'dart:convert';

import 'package:codedutravail/core/config/env.dart';
import 'package:codedutravail/core/utils/logger.dart';
import 'package:codedutravail/data/repositories/ai_functions_repository_impl.dart';
import 'package:codedutravail/domain/repositories/ai_functions_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deepseek/flutter_deepseek.dart' show DeepSeekTool, FunctionDefinition;
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_agent_service.g.dart';

class DeepSeekApiException implements Exception {
  final int statusCode;
  final String body;

  DeepSeekApiException(this.statusCode, this.body);

  @override
  String toString() => 'DeepSeekApiException($statusCode): $body';
}

class DeepSeekEmptyResponseException implements Exception {
  const DeepSeekEmptyResponseException();

  @override
  String toString() => 'DeepSeekEmptyResponseException';
}

@Riverpod(keepAlive: true)
AiAgentService aiAgentService(Ref ref) {
  return AiAgentService(ref.watch(aiFunctionsRepositoryProvider));
}

/// Drives the DeepSeek chat + tool-calling loop directly over HTTP.
///
/// `flutter_deepseek`'s `DeepSeekClient` lets you send a `tools` array via
/// `DeepSeekTool`/`FunctionDefinition`, but its response parsing never reads
/// back `tool_calls` from the API — so it's used here only for those request
/// shapes, while the actual call and the tool-call loop are hand-rolled
/// against the raw REST API.
class AiAgentService {
  final AiFunctionsRepository _repo;
  final http.Client _httpClient = http.Client();

  AiAgentService(this._repo);

  List<Map<String, dynamic>> _history = [];
  List<DeepSeekTool>? _tools;
  String? _systemPrompt;

  static const String _model = 'deepseek-v4-flash';
  static const int _maxLoopCount = 6;

  Future<void> _ensureInitialized() async {
    _systemPrompt ??= await rootBundle.loadString('assets/ai/system_prompt.md');
    _tools ??= _buildTools();
  }

  Future<Map<String, dynamic>> _callApi({String toolChoice = 'auto'}) async {
    final body = jsonEncode({
      'model': _model,
      'messages': [
        {'role': 'system', 'content': _systemPrompt},
        ..._history,
      ],
      'tools': _tools!.map((t) => t.toJson()).toList(),
      'tool_choice': toolChoice,
    });

    final response = await _httpClient
        .post(
          Uri.parse('${Env.deepseekApiUrl}/chat/completions'),
          headers: {'Authorization': 'Bearer ${Env.deepseekAPIKey}', 'Content-Type': 'application/json'},
          body: body,
        )
        .timeout(const Duration(seconds: 60));

    if (response.statusCode != 200) {
      throw DeepSeekApiException(response.statusCode, response.body);
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<String> sendMessage(String text, {void Function(String name, Map<String, dynamic> args)? onToolCall}) async {
    await _ensureInitialized();
    _history.add({'role': 'user', 'content': text});

    var loopCount = 0;

    while (true) {
      final responseJson = await _callApi();
      final usage = responseJson['usage'] as Map<String, dynamic>?;
      if (usage != null) {
        AppLogger.info('[AI] usage: $usage');
      }

      final choices = responseJson['choices'] as List<dynamic>? ?? [];
      if (choices.isEmpty) {
        throw const DeepSeekEmptyResponseException();
      }

      final choice = choices.first as Map<String, dynamic>;
      final message = choice['message'] as Map<String, dynamic>;
      final finishReason = choice['finish_reason'] as String? ?? '';
      final toolCalls = message['tool_calls'] as List<dynamic>?;

      if (finishReason == 'tool_calls' && toolCalls != null && toolCalls.isNotEmpty) {
        loopCount++;
        if (loopCount > _maxLoopCount) {
          AppLogger.warn('[AI] max tool-call loop count ($_maxLoopCount) reached, forcing a final answer');
          return _forceFinalAnswer();
        }

        AppLogger.debug(
          '[AI] tool-call loop iteration $loopCount: ${toolCalls.map((c) => (c as Map)['function']['name']).join(', ')}',
        );

        // Preserve the raw assistant message with tool_calls so the API can
        // link tool results back to the originating call.
        _history.add(message);

        for (final toolCallJson in toolCalls) {
          final toolCall = toolCallJson as Map<String, dynamic>;
          final callId = toolCall['id'] as String;
          final function = toolCall['function'] as Map<String, dynamic>;
          final name = function['name'] as String;
          final argsStr = function['arguments'] as String;
          final args = argsStr.isEmpty ? <String, dynamic>{} : jsonDecode(argsStr) as Map<String, dynamic>;

          AppLogger.info('[AI] -> calling $name args: $args');
          onToolCall?.call(name, args);
          final result = await _dispatch(name, args);

          _history.add({'role': 'tool', 'tool_call_id': callId, 'content': jsonEncode(result)});
        }
        continue;
      }

      final responseText = message['content'] as String? ?? '';
      if (responseText.isEmpty) {
        throw const DeepSeekEmptyResponseException();
      }

      _history.add({'role': 'assistant', 'content': responseText});
      return responseText;
    }
  }

  /// Called when the tool-call loop hits [_maxLoopCount] without the model
  /// ever producing a text answer. Forces one more call with `tool_choice:
  /// 'none'` so the model must synthesize a real answer from whatever it
  /// already gathered in `_history`, instead of the whole turn failing.
  Future<String> _forceFinalAnswer() async {
    final responseJson = await _callApi(toolChoice: 'none');
    final choices = responseJson['choices'] as List<dynamic>? ?? [];
    if (choices.isEmpty) {
      throw const DeepSeekEmptyResponseException();
    }

    final message = (choices.first as Map<String, dynamic>)['message'] as Map<String, dynamic>;
    final responseText = message['content'] as String? ?? '';
    if (responseText.isEmpty) {
      throw const DeepSeekEmptyResponseException();
    }

    _history.add({'role': 'assistant', 'content': responseText});
    return responseText;
  }

  void reset() {
    _history = [];
  }

  // ── tool schema helpers ──────────────────────────────────────────────

  static Map<String, dynamic> _str(String description) => {'type': 'string', 'description': description};

  static Map<String, dynamic> _int(String description) => {'type': 'integer', 'description': description};

  static Map<String, dynamic> _array(String description, Map<String, dynamic> items) => {
    'type': 'array',
    'description': description,
    'items': items,
  };

  static Map<String, dynamic> _params(Map<String, Map<String, dynamic>> properties, {List<String> required = const []}) => {
    'type': 'object',
    'properties': properties,
    if (required.isNotEmpty) 'required': required,
  };

  static DeepSeekTool _tool(String name, String description, Map<String, dynamic> parameters) =>
      DeepSeekTool(function: FunctionDefinition(name: name, description: description, parameters: parameters));

  List<DeepSeekTool> _buildTools() {
    return [
      _tool(
        'get_code_structure',
        'Retourne le plan du Code du travail (titres, chapitres, sections avec leurs intitulés uniquement, sans le texte '
            'des articles). À appeler au maximum une fois par conversation.',
        _params({}),
      ),
      _tool(
        'search_articles',
        'Recherche des articles par mots-clés (correspondance lexicale approximative, pas sémantique). Enrichis toi-même '
            'les mots-clés avec des synonymes et le vocabulaire juridique apparenté. Utilise title_number/chapter_number/'
            'section_number pour borner la recherche à une partie précise du code.',
        _params(
          {
            'keywords': _array(
              'Mots-clés à rechercher, incluant synonymes et termes juridiques apparentés à la question',
              _str('mot-clé'),
            ),
            'title_number': _int('Numéro du titre pour borner la recherche (optionnel)'),
            'chapter_number': _int('Numéro du chapitre pour borner la recherche, nécessite title_number (optionnel)'),
            'section_number': _int(
              'Numéro de la section pour borner la recherche, nécessite title_number et chapter_number (optionnel)',
            ),
            'limit': _int('Nombre maximum de résultats, défaut 5, plafonné à 10 (optionnel)'),
          },
          required: ['keywords'],
        ),
      ),
      _tool(
        'get_article_by_number',
        "Récupère le texte exact d'un article dont le numéro est déjà connu.",
        _params({'number': _int("Numéro de l'article")}, required: ['number']),
      ),
    ];
  }

  // ── dispatch ─────────────────────────────────────────────────────────

  Future<Map<String, dynamic>> _dispatch(String name, Map<String, dynamic> args) async {
    try {
      switch (name) {
        case 'get_code_structure':
          return await _repo.getCodeStructure();

        case 'search_articles':
          final keywords = (args['keywords'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? <String>[];
          return {
            'articles': await _repo.searchArticles(
              keywords: keywords,
              titleNumber: (args['title_number'] as num?)?.toInt(),
              chapterNumber: (args['chapter_number'] as num?)?.toInt(),
              sectionNumber: (args['section_number'] as num?)?.toInt(),
              limit: (args['limit'] as num?)?.toInt() ?? 5,
            ),
          };

        case 'get_article_by_number':
          final article = await _repo.getArticleByNumber((args['number'] as num).toInt());
          return article ?? {'error': 'article_not_found'};

        default:
          return {'error': 'unknown_function: $name'};
      }
    } catch (e, st) {
      AppLogger.error('[AI] dispatch error in "$name"', error: e, stackTrace: st);
      return {'error': e.toString()};
    }
  }
}
