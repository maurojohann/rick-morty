import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:pagination_challenge/shared/data/http/http.dart';
import 'package:pagination_challenge/shared/domain/entities/entities.dart';
import 'package:pagination_challenge/features/characters/domain/entities/entities.dart';
import 'package:pagination_challenge/features/characters/domain/helpers/errors/errors.dart';

import 'package:pagination_challenge/features/characters/data/usecases/fetch_characters_usecases_imp.dart';

class MockHttpClientsDataSources extends Mock implements HttpClientDataSources {}

class MockListResponse extends Mock implements ListResponse<CharacterEntity> {}

void main() {
  late String url;
  late MockHttpClientsDataSources httpClientDataSourcesImp;
  late FetchCharactersUsecasesImp sut;
  var jsonResponse = {
    "info": {
      "count": 826,
      "pages": 42,
      "next": "https://rickandmortyapi.com/api/character/?page=20",
      "prev": "https://rickandmortyapi.com/api/character/?page=18"
    },
    "results": [
      {
        "id": 361,
        "name": "Toxic Rick",
        "status": "Dead",
        "species": "Humanoid",
        "type": "Rick's Toxic Side",
        "gender": "Male",
        "origin": {"name": "Alien Spa", "url": "https://rickandmortyapi.com/api/location/64"},
        "location": {"name": "Earth", "url": "https://rickandmortyapi.com/api/location/20"},
        "image": "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
        "episode": ["https://rickandmortyapi.com/api/episode/27"],
        "url": "https://rickandmortyapi.com/api/character/361",
        "created": "2018-01-10T18:20:41.703Z"
      },
    ]
  };

  When mockHttpClientDataSourcesRequest([String? method]) {
    return when(
      () => httpClientDataSourcesImp.request(url: url, method: method ?? any(named: 'method')),
    );
  }

  mockHttpClientDataSourcesResponse(Map map, [String? method]) {
    mockHttpClientDataSourcesRequest(method).thenAnswer((data) async {
      return map;
    });
  }

  mockHttpClientDataSourcesResponseError(HttpError error) {
    mockHttpClientDataSourcesRequest().thenThrow(error);
  }

  setUp(
    () {
      url = Faker().internet.httpUrl();
      httpClientDataSourcesImp = MockHttpClientsDataSources();
      sut = FetchCharactersUsecasesImp(httpClient: httpClientDataSourcesImp, url: url);
      mockHttpClientDataSourcesResponse(jsonResponse, 'get');
    },
  );

  test(
    'Ensure httpClient load with correct data',
    () async {
      await sut();

      verify(() => httpClientDataSourcesImp.request(url: url, method: 'get'));
    },
  );
  test(
    'Ensure httpClient load with invalid data',
    () async {
      mockHttpClientDataSourcesResponse({'results': 'invalid_value'});
      final future = sut();

      expect(future, throwsA(DomainError.invalidData));
    },
  );
  test(
    'Should return a ListResponse if httpClient return validated response',
    () async {
      final future = await sut();

      expect(future.listData[0].id, 361);
    },
  );
  test(
    'Should return a DomainError if httpClient throw a HttpError',
    () async {
      mockHttpClientDataSourcesResponseError(HttpError.serverError);

      final future = sut();

      expect(future, throwsA(DomainError.unexpected));
    },
  );
}
