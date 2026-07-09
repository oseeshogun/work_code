import 'package:codedutravail/core/domain/usecases/usecase.dart';
import 'package:codedutravail/data/repositories/ai_agent_repository_impl.dart';
import 'package:codedutravail/domain/repositories/ai_agent_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'increment_daily_chat_use.g.dart';

@Riverpod(keepAlive: true)
IncrementDailyChatUseCase incrementDailyChat(Ref ref) {
  final aiAgentRepository = ref.watch(aiAgentRepositoryProvider);
  return IncrementDailyChatUseCase(aiAgentRepository);
}

class IncrementDailyChatUseCase extends UseCase<void> {
  final AiAgentRepository _aiAgentRepository;

  IncrementDailyChatUseCase(this._aiAgentRepository);

  @override
  Future<void> execute() async {
    await _aiAgentRepository.incrementDailyChatCount();
  }
}