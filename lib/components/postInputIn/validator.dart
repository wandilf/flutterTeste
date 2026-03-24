class Validators {
  static String? validaTitulo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Titulo obrigatório";
    }
    return null;
  }

  static String? validaDescricao(String? value, int min) {
    if (value == null || value.length < min) {
      return "Descrição mínimo de $min caracteres";
    }
    return null;
  }
}
