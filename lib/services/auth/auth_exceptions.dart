// login exceptions
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// Register exceptions
class InvalidEmailAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

// Generic Exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
