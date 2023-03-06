import 'package:faker/faker.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:pagination_challenge/shared/data/http/error/http_error.dart';
import 'package:pagination_challenge/shared/infra/http/http_adapter.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeUri());
  });
  group('Get', () {
    test('Ensure call get with correct Url', () async {
      final url = Faker().internet.httpsUrl();
      final mockClient = MockClient();
      final sut = HttpAdapter(mockClient);

      when(
        () => mockClient.get(any()),
      ).thenAnswer((invocation) async => http.Response('''{"key":"value"}''', 200));

      await sut.request(url: url, method: 'get');

      verify(() => mockClient.get(Uri.parse(url)));
    });
    test('Should call get method and return statusCode 200', () async {
      final url = Faker().internet.httpsUrl();
      final client = MockClient();
      final sut = HttpAdapter(client);

      final responses = MockResponse();

      when(() => responses.statusCode).thenReturn(200);
      when(() => responses.body).thenReturn('''''');

      when(() => client.get(any())).thenAnswer((_) async => responses);

      final resultBody = sut.request(url: url, method: 'get');

      expect(resultBody, throwsA(HttpError.invalidResponse));
    });
    test('Should call get method and return httpError', () async {
      final url = Faker().internet.httpsUrl();
      final client = MockClient();
      final sut = HttpAdapter(client);
      final responses = MockResponse();
      when(() => responses.statusCode).thenReturn(400);

      when(() => client.get(any())).thenAnswer((_) async => responses);

      final httpError = sut.request(url: url, method: 'get');

      expect(httpError, throwsA(HttpError.serverError));
    });
  });
}
