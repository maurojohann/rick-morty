

import '../../../../shared/data/http/datasources/http_client_datasources.dart';
import '../../../../shared/data/http/error/http_error.dart';
import '../../../../shared/domain/entities/entities.dart';
import '../../../../shared/domain/usecases/usecase.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/errors/errors.dart';


import '../models/models.dart';


class FetchCharactersUsecasesImp extends UseCase<String?, ListResponse<CharacterEntity>> {
  final HttpClientDataSources httpClient;
  final String url;

  FetchCharactersUsecasesImp({required this.httpClient, required this.url});

  @override
  Future<ListResponse<CharacterEntity>> call([String? param]) async {
    
    try {
      var httpResponse = await httpClient.request(url: param ?? url, method: 'get');
      if (httpResponse?.containsKey('results') ?? false) {
        var characterResult = httpResponse!['results'] as List;

        var charactersEntityList = characterResult.map(
          (e) {
            return CharacterModels.fromMap(e).toEntity();
          },
        ).toList();

        var paginantionInfoEntity = PaginationInfoModels.fromMap(httpResponse['info']).toEntity();

        return ListResponse<CharacterEntity>(charactersEntityList, paginantionInfoEntity);
      } else {
         throw DomainError.invalidData;
      }
    } on HttpError catch (e) {
      if (e == HttpError.invalidResponse) {
        throw DomainError.invalidData;
      } else {
        throw DomainError.unexpected;
      }
    } on TypeError {
      throw DomainError.invalidData;
    }
  }
}
