part of 'characters_bloc.dart';

abstract class CharactersState {}

class CharactersInitialState extends CharactersState {}

class CharactersLoadedState extends CharactersState {
  final ListResponse<CharacterEntity> listCharacterEntity;

  CharactersLoadedState(this.listCharacterEntity);
}

class CharactersErrorState extends CharactersState {
  final String message;

  CharactersErrorState(this.message);
}
