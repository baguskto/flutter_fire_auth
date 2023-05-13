import 'package:flutter_fire_auth/domain/core/helper/validation_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ValidationHelper', () {
    test('validateName should return error for empty name', () {
      expect(ValidationHelper.validateName(''), 'Nama tidak boleh kosong');
    });

    test('validateName should return error for name less than 3 characters', () {
      expect(ValidationHelper.validateName('ab'), 'Nama minimal 3 huruf');
    });

    test('validateName should return error for name more than 50 characters', () {
      expect(ValidationHelper.validateName('a'*51), 'Nama maksimal 50 huruf');
    });

    test('validateName should return null for valid name', () {
      expect(ValidationHelper.validateName('ValidName'), null);
    });

    test('validateEmail should return error for empty email', () {
      expect(ValidationHelper.validateEmail(''), 'Email tidak boleh kosong');
    });

    test('validateEmail should return error for invalid email', () {
      expect(ValidationHelper.validateEmail('invalidEmail'), 'Masukkan email yang valid');
    });

    test('validateEmail should return null for valid email', () {
      expect(ValidationHelper.validateEmail('valid@example.com'), null);
    });

    test('validatePassword should return error for empty password', () {
      expect(ValidationHelper.validatePassword(''), 'Password tidak boleh kosong');
    });

    test('validatePassword should return error for password not meeting criteria', () {
      expect(ValidationHelper.validatePassword('simple'), 'Password harus mengandung minimal 8 karakter, angka, huruf besar dan kecil');
    });

    test('validatePassword should return null for valid password', () {
      expect(ValidationHelper.validatePassword('Valid123'), null);
    });

    test('validateConfirmPassword should return error for empty confirm password', () {
      expect(ValidationHelper.validateConfirmPassword('password', ''), 'Konfirmasi password tidak boleh kosong');
    });

    test('validateConfirmPassword should return error for non-matching passwords', () {
      expect(ValidationHelper.validateConfirmPassword('password1', 'password2'), 'Konfirmasi password harus sama dengan password');
    });

    test('validateConfirmPassword should return null for matching passwords', () {
      expect(ValidationHelper.validateConfirmPassword('password', 'password'), null);
    });
  });
}
