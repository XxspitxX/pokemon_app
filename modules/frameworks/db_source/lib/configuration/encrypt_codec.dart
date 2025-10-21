import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:sembast/sembast.dart';

var _random = Random.secure();

Uint8List _randBytes(int length) {
  return Uint8List.fromList(
    List<int>.generate(length, (i) => _random.nextInt(256)),
  );
}

Uint8List _generateEncryptPassword(String password) {
  var blob = Uint8List.fromList(md5.convert(utf8.encode(password)).bytes);
  assert(blob.length == 16);
  return blob;
}

class _EncryptEncoder extends Converter<Object?, String> {
  final Salsa20 salsa20;

  _EncryptEncoder(this.salsa20);

  @override
  String convert(dynamic input) {
    final iv = _randBytes(8);
    final ivEncoded = base64.encode(iv);
    assert(ivEncoded.length == 12);

    final encoded = Encrypter(
      salsa20,
    ).encrypt(json.encode(input), iv: IV(iv)).base64;

    return '$ivEncoded$encoded';
  }
}

class _EncryptDecoder extends Converter<String, Object?> {
  final Salsa20 salsa20;

  _EncryptDecoder(this.salsa20);

  @override
  dynamic convert(String input) {
    assert(input.length >= 12);
    final iv = base64.decode(input.substring(0, 12));

    input = input.substring(12);

    var decoded = json.decode(Encrypter(salsa20).decrypt64(input, iv: IV(iv)));
    if (decoded is Map) {
      return decoded.cast<String, Object?>();
    }
    return decoded;
  }
}

class _EncryptCodec extends Codec<Object?, String> {
  late _EncryptEncoder _encoder;
  late _EncryptDecoder _decoder;

  _EncryptCodec(Uint8List passwordBytes) {
    var salsa20 = Salsa20(Key(passwordBytes));
    _encoder = _EncryptEncoder(salsa20);
    _decoder = _EncryptDecoder(salsa20);
  }

  @override
  Converter<String, Object?> get decoder => _decoder;

  @override
  Converter<Object?, String> get encoder => _encoder;
}

const _encryptCodecSignature = 'encrypt';

SembastCodec getEncryptSembastCodec({required String password}) => SembastCodec(
  signature: _encryptCodecSignature,
  codec: _EncryptCodec(_generateEncryptPassword(password)),
);

class EncryptedDatabaseFactory implements DatabaseFactory {
  final DatabaseFactory databaseFactory;
  late final SembastCodec codec;

  EncryptedDatabaseFactory({
    required this.databaseFactory,
    required String password,
  }) {
    codec = getEncryptSembastCodec(password: password);
  }

  @override
  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);

  @override
  bool get hasStorage => databaseFactory.hasStorage;

  @override
  Future<bool> databaseExists(String path) {
    return databaseFactory.databaseExists(path);
  }

  @override
  Future<Database> openDatabase(
    String path, {
    int? version,
    OnVersionChangedFunction? onVersionChanged,
    DatabaseMode? mode,
    SembastCodec? codec,
  }) {
    assert(codec == null);
    return databaseFactory.openDatabase(
      path,
      version: version,
      onVersionChanged: onVersionChanged,
      mode: mode,
      codec: this.codec,
    );
  }
}
