import 'package:flutter/material.dart';

import '../data/models/local/modulos.dart';

class Globais {
  static const String urlBase = "https://localhost:7050/api/";
  // static const String urlBase = "https://api.ccmn.org.br/api/";

  static bool isAdmin = false;

  static bool moduloHospedagem = false;
  static bool moduloControleEstoque = false;
  static bool moduloFinanceiro = false;
  static bool moduloSorteios = true;
  static bool moduloAdmin = true;

  static Modulos modulosPermitidos = Modulos(
    moduloHospedagem: moduloHospedagem,
    moduloControleEstoque: moduloControleEstoque,
    moduloFinanceiro: moduloFinanceiro,
    moduloSorteios: moduloSorteios,
    moduloAdmin: moduloAdmin,
  );

  static String moduloLogado = "";

  static int codigoUsuario = 0;
  static String nomePessoa = "CCMN Manager";

  static Map<String, Widget Function(BuildContext)> rotas = {
    // '/estrutura': (context) => const EstruturaPage(),
    // '/hospedagem': (context) => const HospedagemPage(),
    // '/estoque': (context) => const EstoquePage(),
    // '/financeiro': (context) => const FinanceiroPage(),
  };
}
