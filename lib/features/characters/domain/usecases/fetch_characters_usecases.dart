import '../entities/character_entity.dart';

abstract class FetchCharactersUsecases {
  Future<List<CharacterEntity>> load();
}
