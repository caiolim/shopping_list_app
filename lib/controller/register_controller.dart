class RegisterController {
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

  String? validateConfirmPassword(String? text, textPassword) {
    if (text == null || text.isEmpty) {
      return 'Informe a confirmação da senha';
    } else if (text != textPassword) {
      return 'As senhas devem ser iguais';
    }

    return null;
  }

  String? validateName(String? text) {
    if (text == null || text.isEmpty) {
      return 'Informe seu nome';
    }

    return null;
  }

  String? validateBirthDate(String? text) {
    if (text == null || text.isEmpty) {
      return 'Informe sua data de nascimento';
    }

    return null;
  }
}

enum Gender { male, female }
