import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/pages/financeiro/servicos/novo_servico.dart';
import 'package:painel_ccmn/pages/pages.dart';

class Servicos extends StatefulWidget {
  const Servicos({super.key});

  @override
  State<Servicos> createState() => _ServicosState();
}

class _ServicosState extends State<Servicos> {
  bool carregando = false;

  buscarServicos() async {
    setState(() => carregando = true);
    setState(() => carregando = false);
    // setState(() => carregando = true);
    // await Servico.buscarServicos().then((value) {
    //   setState(() {
    //     listaServicos = value;
    //     carregando = false;
    //   });
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarServicos();
  }

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Novo Serviço",
      tituloPagina: "Serviços",
      abrirTelaCadastro: () => Navigator.push(
          context,
          CupertinoDialogRoute(
              builder: (context) => const NovoServico(), context: context)),
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
