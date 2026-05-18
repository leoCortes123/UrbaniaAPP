sealed class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('Verifica tu conexión a internet');
}

class ServerFailure extends Failure {
  const ServerFailure() : super('Error del servidor. Inténtalo más tarde');
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super('Sesión expirada. Inicia sesión de nuevo');
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}

class ConflictFailure extends Failure {
  const ConflictFailure(String message) : super(message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure() : super('Recurso no encontrado');
}

class BusinessLogicFailure extends Failure {
  const BusinessLogicFailure(String message) : super(message);
}

class DemoModeFailure extends Failure {
  const DemoModeFailure(String message) : super(message);
}