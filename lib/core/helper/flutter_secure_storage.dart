import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
 class AppSecureStorage {
 FlutterSecureStorage _storage ();

  AppSecureStorage(this._storage);

Future<void> write(String token) async {
  await _storage.write(key: 'token', value: token);
}

Future<String> read() async {
  return await _storage.read(key: 'token') ?? '';
}

Future<void> delete() async {
  await _storage.delete(key: 'token');
}
Future<void>deleteAll()async{
  await _storage.deleteAll();
}
}
