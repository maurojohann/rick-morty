import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pagination_challenge/shared/domain/usecases/usecase.dart';

import '../../../../shared/domain/entities/entities.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/helpers/errors/errors.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final UseCase<String?, ListResponse<CharacterEntity>> fetchCharacters;
  final UseCase<String?, ListResponse<CharacterEntity>> fetchCharactersFilter;
  CharactersBloc(this.fetchCharacters, this.fetchCharactersFilter) : super(CharactersInitialState()) {
    on<LoadCharactersEvent>(_loadCharactersEvent);
    on<CharactersFilterEvent>(_charactersFilterEvent);
  }

  Future<void> _loadCharactersEvent(
    LoadCharactersEvent event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      late ListResponse<CharacterEntity> listCharacters;
      CharactersState state = this.state;

      if (state is CharactersLoadedState) {
        listCharacters = await fetchCharacters(state.listCharacterEntity.paginationInfoEntity.next);
        var newListData = state.listCharacterEntity.listData..addAll(listCharacters.listData);
        var newPaginationInfo = listCharacters.paginationInfoEntity;
        listCharacters = ListResponse<CharacterEntity>(newListData, newPaginationInfo);
      } else {
        listCharacters = await fetchCharacters();
      }
      emit(CharactersLoadedState(listCharacters));
    } on DomainError catch (e) {
      if (e == DomainError.invalidData) {
        emit(CharactersErrorState('Não foi possível carregar personagens'));
      } else {
        emit(CharactersErrorState('Um erro inesperado  ocorreu!'));
      }
    }
  }

  Future<void> _charactersFilterEvent(CharactersFilterEvent event, Emitter<CharactersState> emit) async {
    try {
      late ListResponse<CharacterEntity> listCharacters;

      emit(CharactersInitialState());

      listCharacters = await fetchCharactersFilter(event.filterParams);

      emit(CharactersLoadedState(listCharacters));
    } on DomainError catch (e) {
      if (e == DomainError.invalidData) {
        emit(CharactersErrorState('Não foi possível carregar personagens'));
      } else if (e == DomainError.notFound) {
        emit(CharactersErrorState('Personagem não encontrado'));
      } else {
        emit(CharactersErrorState('Um erro inesperado ocorreu!'));
      }
    }
  }
}
