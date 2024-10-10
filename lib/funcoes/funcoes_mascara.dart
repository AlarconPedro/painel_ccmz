class FuncoesMascara {
  static String mascaraTelefone(String telefone) {
    if (telefone.isEmpty) {
      return '';
    }
    if (telefone.length == 10) {
      return '(${telefone.substring(0, 2)}) ****-${telefone.substring(6, 10)}';
    } else {
      return '(${telefone.substring(0, 2)}) *****-${telefone.substring(7, 11)}';
    }
  }

  static String mascaraCpf(String cpf) {
    if (cpf.isEmpty) {
      return '';
    }
    return '${cpf.substring(0, 3)}.***.${cpf.substring(6, 9)}-**';
  }
}
