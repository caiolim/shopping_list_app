class LoginController {
  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return 'Informe o e-mail';
    } else if (text.length < 6 || !text.contains('@')) {
      return 'Informe um e-mail válido';
    }

    return null;
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return 'Informe a senha';
    }

    return null;
  }
}
