class Globais {
  static const String urlBase = "https://localhost:7050/api/";
  // static const String urlBase = "http://api.ccmn.org.br/api/";

  static bool isAdmin = false;

  static bool moduloHospedagem = false;
  static bool moduloControleEstoque = false;
  static bool moduloFinanceiro = false;

  static List<bool> modulosPermitidos = [];

  static String moduloLogado = "";

  static int codigoUsuario = 0;
  static String nomePessoa = "CCMN Manager";
}
