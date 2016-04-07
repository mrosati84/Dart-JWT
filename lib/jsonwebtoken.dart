import 'package:crypto/crypto.dart';
import 'dart:convert';

/// Constant [HS256] identifies the HS256 crypt method.
const HS256 = 'HS256';

/// The default "typ" provided by [DEFAULT_TYP].
const DEFAULT_TYP = 'JWT';

class JsonWebToken {
  Map _header = {'typ': DEFAULT_TYP};
  Map _payload;
  String _secret;
  String _encodedToken;

  /// Constructor for the HS256 algorithm.
  /// [secret] is the mandatory secret key used for encryption.
  /// [payload] represents the actual content of the token.
  /// [header] is optional and overrides the default header.
  JsonWebToken.hs256(String secret, Map payload, {Map header}) {
    this._header['alg'] = 'HS256';

    if (_header != null) {
      this._header = _header;
    }

    this._payload = payload;
    this._secret = secret;
  }

  /// Getter for [_encodedToken]
  String get token => _encodedToken;

  /// Encodes a token using the provided secret, header and payload.
  bool encode() {
    Base64Encoder base64Encoder = new Base64Encoder();
    String b64Header = base64Encoder.convert(UTF8.encode(JSON.encode(this._header)));
    String b64Payload = base64Encoder.convert(UTF8.encode(JSON.encode(this._payload)));

    Hmac hmac = new Hmac(sha256.newInstance(), UTF8.encode(this._secret));
    Digest signature = hmac.convert(UTF8.encode("${b64Header}.${b64Payload}"));
    String encodedSignature = base64Encoder.convert(signature.bytes);

    this._encodedToken = "${b64Header}.${b64Payload}.${encodedSignature}";

    return true;
  }
}
