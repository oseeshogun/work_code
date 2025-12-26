import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_response.freezed.dart';
part 'ai_response.g.dart';

@freezed
abstract class AiResponse with _$AiResponse {
  const factory AiResponse({
    required String token,
    String? modelName,
    String? modelProvider,
    int? totalTokens,
    String? functionName,
  }) = _AiResponse;

  factory AiResponse.fromJson(Map<String, Object?> json) => _$AiResponseFromJson(json);
}
