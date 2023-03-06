part of 'characters_bloc.dart';


abstract class CharactersEvent {}

class LoadCharactersEvent extends CharactersEvent {
  final String? nextPage;

  LoadCharactersEvent([this.nextPage]);
}

class CharactersFilterEvent extends CharactersEvent {
  final String? filterParams;

  CharactersFilterEvent([this.filterParams]);
}
