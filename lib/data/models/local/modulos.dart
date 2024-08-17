class Modulos {
  bool moduloHospedagem;
  bool moduloControleEstoque;
  bool moduloFinanceiro;
  bool moduloSorteios;
  bool moduloAdmin;

  Modulos({
    required this.moduloHospedagem,
    required this.moduloControleEstoque,
    required this.moduloFinanceiro,
    required this.moduloSorteios,
    required this.moduloAdmin,
  });

  int getModulosPermitidos() {
    int qtdModulos = 0;
    if (moduloHospedagem) qtdModulos++;
    if (moduloControleEstoque) qtdModulos++;
    if (moduloFinanceiro) qtdModulos++;
    if (moduloSorteios) qtdModulos++;
    if (moduloAdmin) qtdModulos++;
    return qtdModulos;
  }
}
