import 'package:codedutravail/core/domain/usecases/usecase.dart';
import 'package:codedutravail/data/repositories/ai_agent_repository_impl.dart';
import 'package:codedutravail/domain/repositories/ai_agent_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'does_reach_daily_chat_limit.g.dart';

@Riverpod(keepAlive: true)
DoesReachDailyChatLimitUseCase doesReachDailyChatLimit(Ref ref) {
  final aiAgentRepository = ref.watch(aiAgentRepositoryProvider);
  return DoesReachDailyChatLimitUseCase(aiAgentRepository);
}

class DoesReachDailyChatLimitUseCase extends UseCase<bool> {
  final AiAgentRepository _aiAgentRepository;

  DoesReachDailyChatLimitUseCase(this._aiAgentRepository);

  @override
  Future<bool> execute() async {
    return await _aiAgentRepository.doesReachDailyChatLimit();
  }
}