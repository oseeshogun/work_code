abstract class Env {
  static const String llmApiUrl = String.fromEnvironment('llmApiUrl');

  static const int appProjectId = int.fromEnvironment('appProjectId');

  static const String serverSessionKey = String.fromEnvironment('serverSessionKey');
}
