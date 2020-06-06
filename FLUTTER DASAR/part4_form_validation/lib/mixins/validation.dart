class Validation {
  // FUNGSI validatePassword > NAMA FUNGSI BEBAS

  String validatePassword(String value) {
    if (value.length < 6) {
      return 'Password minimal 6 Karakter';
    }
    return null;
  }

  String validateEmail(String value) {
    if (!value.contains('@') || !value.contains('.')) {
      return 'Email tidak valid';
    }
    return null;
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return 'Nama lengkap harus diisi';
    }
    return null;
  }
}
