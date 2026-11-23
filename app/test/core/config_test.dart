import 'package:flutter_test/flutter_test.dart';
import 'package:summa/core/config.dart';

void main() {
  test('a backend on this machine is reached without TLS', () {
    expect(AppConfig.useTlsFor('localhost'), isFalse);
    expect(AppConfig.useTlsFor('127.0.0.1'), isFalse);
    expect(AppConfig.useTlsFor('10.0.2.2'), isFalse);
  });

  test('any other host is reached over TLS', () {
    expect(AppConfig.useTlsFor('api.example.com'), isTrue);
    expect(AppConfig.useTlsFor('192.168.1.20'), isTrue);
  });
}
