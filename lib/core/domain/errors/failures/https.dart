import 'package:codedutravail/core/domain/errors/failures.dart';

class NotInternetFailure extends Failure {
  NotInternetFailure(super.exception);

  @override
  String get message => "Aucune connexion internet.";
}

class BadRequestFailure extends Failure {
  BadRequestFailure(super.exception);

  @override
  String get message => "La requête est invalide.";
}

class NotFoundFailure extends Failure {
  NotFoundFailure(super.exception);

  @override
  String get message => "La ressource demandée est introuvable.";
}

class ForbiddenFailure extends Failure {
  ForbiddenFailure(super.exception);

  @override
  String get message => "Accès interdit à la ressource demandée.";
}

class InternalServerFailure extends Failure {
  InternalServerFailure(super.exception);

  @override
  String get message => "Erreur interne du serveur.";
}

class ServiceUnavailableFailure extends Failure {
  ServiceUnavailableFailure(super.exception);

  @override
  String get message => "Le service est actuellement indisponible.";
}

class TooManyRequestsFailure extends Failure {
  TooManyRequestsFailure(super.exception);

  @override
  String get message => "Trop de requêtes ont été effectuées.";
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure(super.exception);

  @override
  String get message => "Authentification requise pour accéder à cette ressource.";
}

class RequestConflictFailure extends Failure {
  RequestConflictFailure(super.exception);

  @override
  String get message => "La requête est en conflit avec l'état actuel du serveur.";
}

class RequestTimeoutFailure extends Failure {
  RequestTimeoutFailure(super.exception);

  @override
  String get message => "La requête a expiré.";
}
