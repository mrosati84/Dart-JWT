import 'package:test/test.dart';
import 'package:jwt/jsonwebtoken.dart';

void main() {
  test("it can generate jwt tokens", () {
    JsonWebToken jwt = new JsonWebToken.hs256('secret', {'test': 'test'});
    expect(jwt.encode(), equals('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZXN0IjoidGVzdCJ9.6W8hJp4ivZnoU3UpjoshpS5tkXWXHQg05EcZTXrUQZQ='));
  });
}
