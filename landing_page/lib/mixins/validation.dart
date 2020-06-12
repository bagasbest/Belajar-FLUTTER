class Validation {
  String validateEmail (String value) {
    if(!value.contains('@') || !value.contains('.')){
      return 'Maaf, Email tidak valid';
    }
    return null;
  }
}