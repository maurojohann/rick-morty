import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:pagination_challenge/features/characters/presenter/bloc/characters_bloc.dart';

import '../../features/characters/data/usecases/usecases.dart';
import '../../features/characters/domain/entities/entities.dart';

import '../../shared/domain/entities/entities.dart';
import '../../shared/domain/usecases/usecase.dart';
import '../../shared/data/http/datasources/http_client_datasources.dart';
import '../../shared/infra/http/http_adapter.dart';

import '../app/config/api_config.dart';

GetIt serviceLocator = GetIt.instance;

class GlobalDependencies {
  static final GlobalDependencies _singleton = GlobalDependencies._internal();

  factory GlobalDependencies() {
    return _singleton;
  }

  GlobalDependencies._internal();

  Future<void> setup() async {
    GetIt getIt = GetIt.I;
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    getIt.registerSingleton<GlobalKey<NavigatorState>>(navigatorKey);

    final http.Client client = http.Client();
    getIt.registerSingleton<http.Client>(client);

    //DataSources
    getIt.registerSingleton<HttpClientDataSources>(HttpAdapter(getIt()));

    // UseCases
    getIt.registerSingleton<UseCase<String?, ListResponse<CharacterEntity>>>(
        FetchCharactersFilterUsecasesImp(
          httpClient: getIt(),
          url: '$baseURL/character/',
        ),
        instanceName: 'FetchCharactersFilterUsecasesImp');
    getIt.registerSingleton<UseCase<String?, ListResponse<CharacterEntity>>>(
        FetchCharactersUsecasesImp(
          httpClient: getIt(),
          url: '$baseURL/character/',
        ),
        instanceName: 'FetchCharactersUsecasesImp');

    // Chara BLoc
    getIt.registerFactory<CharactersBloc>(() => CharactersBloc(
        getIt(instanceName: 'FetchCharactersUsecasesImp'), getIt(instanceName: 'FetchCharactersFilterUsecasesImp')));
  }
}
