class ValidationHelper {
  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Nama tidak boleh kosong';
    } else if (value.length < 3) {
      return 'Nama minimal 3 huruf';
    } else if (value.length > 50) {
      return 'Nama maksimal 50 huruf';
    }
    return null;
  }

  static String? validateEmail(String value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(pattern);

    if (value.isEmpty) {
      return 'Email tidak boleh kosong';
    } else if (!regex.hasMatch(value)) {
      return 'Masukkan email yang valid';
    }
    return null;
  }

  static String? validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = RegExp(pattern);

    if (value.isEmpty) {
      return 'Password tidak boleh kosong';
    } else if (!regex.hasMatch(value)) {
      return 'Password harus mengandung minimal 8 karakter, angka, huruf besar dan kecil';
    }
    return null;
  }

  static String? validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Konfirmasi password tidak boleh kosong';
    } else if (password != confirmPassword) {
      return 'Konfirmasi password harus sama dengan password';
    }
    return null;
  }
}
