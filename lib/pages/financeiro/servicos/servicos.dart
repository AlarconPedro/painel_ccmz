import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/pages/pages.dart';

class Servicos extends StatefulWidget {
  const Servicos({super.key});

  @override
  State<Servicos> createState() => _ServicosState();
}

class _ServicosState extends State<Servicos> {
  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Novo Serviço",
      tituloPagina: "Serviços",
      abrirTelaCadastro: () {},
      corpo: [],
      buscaNome: (busca) {},
    );
    // return modeloListagemCadastro(
    //   fncBusca: (busca) {},
    //   fncAbrirCadastro: () {},
    //   ctlrBusca: TextEditingController(),
    //   listaDados: [],
    //   cardListagem: (dados) {},
    //   tituloColunas: Row(
    //     children: [],
    //   ),
    //   titulo: "Serviço",
    //   btnTitulo: "Novo Serviço",
    //   carregando: false,
    //   context: context,
    // );
  }
}
