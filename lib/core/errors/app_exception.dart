/// Base type for expected, user-facing failures.
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Thrown when user input does not satisfy domain rules.
final class ValidationException extends AppException {
  const ValidationException(super.message);
}

/// Thrown when an entity referenced by the UI no longer exists.
final class NotFoundException extends AppException {
  const NotFoundException(super.message);
}
