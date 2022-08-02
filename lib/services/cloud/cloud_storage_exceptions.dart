import 'package:flutter/foundation.dart';
@immutable
class CloudStorageExceptions implements Exception {
  const CloudStorageExceptions();
}

class CouldNotCreateNote extends CloudStorageExceptions{}

class CouldNotRetrieveUserNotes extends CloudStorageExceptions{}

class CouldNotUpdateNote extends CloudStorageExceptions{}

class CouldNotDeleteNote extends CloudStorageExceptions{}

