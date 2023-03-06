import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_challenge/features/characters/presenter/components/character_details_page/character_details_page.dart';

import '../../../shared/domain/entities/entities.dart';
import '../domain/entities/entities.dart';
import 'bloc/characters_bloc.dart';
import 'widget/list_view_item.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  ListResponse<CharacterEntity>? characterList;
  @override
  void initState() {
    super.initState();
    context.read<CharactersBloc>().add(LoadCharactersEvent());
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<CharactersBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text('Rick&Morty')),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                bloc.add(CharactersFilterEvent(value));
              },
              decoration: InputDecoration(
                  hintText: 'Busca',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),
          ),
          BlocBuilder<CharactersBloc, CharactersState>(
            builder: (context, state) {
              if (state is CharactersInitialState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CharactersErrorState) {
                return Center(child: Text(state.message));
              } else if (state is CharactersLoadedState) {
                characterList = state.listCharacterEntity;

                return characterList == null
                    ? const Center(child: Text('Nenhum item encontrado'))
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index == (characterList!.listData.length - 1) &&
                                characterList?.paginationInfoEntity.next != null) {
                              context.read<CharactersBloc>().add(
                                    LoadCharactersEvent(characterList?.paginationInfoEntity.next),
                                  );
                            }
                            var character = characterList!.listData[index];
                            return ListViewItem(character: character);
                          },
                          itemCount: characterList?.listData.length ?? 0,
                        ),
                      );
              } else {
                return const Center(child: Text('Nenhum item encontrado'));
              }
            },
          ),
        ],
      ),
    );
  }
}
