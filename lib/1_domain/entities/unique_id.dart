import 'package:uuid/uuid.dart';

class UniqueId {
  const UniqueId._(this.value);
  
  final String value;
  
  factory UniqueId() {
    return UniqueId._(const Uuid().v4());
  }

  factory UniqueId.fromUniqueString(String uniqueString) {
    return UniqueId._(uniqueString);
  }
}

class CollectionId extends UniqueId {
  const CollectionId._(super.value) : super._();

  factory CollectionId() {
    return CollectionId._(const Uuid().v4());
  }

  factory CollectionId.fromUniqueString(String uniqueString) {
    return CollectionId._(uniqueString);
  }
}

class EntryId extends UniqueId {
  const EntryId._(super.value) : super._();

  factory EntryId() {
    return EntryId._(const Uuid().v4());
  }

  factory EntryId.fromUniqueString(String uniqueString) {
    return EntryId._(uniqueString);
  }
}