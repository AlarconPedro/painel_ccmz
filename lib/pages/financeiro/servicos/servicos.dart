import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/data/models/web/servicos_model.dart';
import 'package:painel_ccmn/pages/financeiro/servicos/novo_servico.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../../classes/classes.dart';
import '../../../widgets/cards/listagem/card_servicos.dart';

class Servicos extends StatefulWidget {
  bool selecionado;
  Function(int, String)? selecionarServico;
  Servicos({super.key, this.selecionado = false, this.selecionarServico});

  @override
  State<Servicos> createState() => _ServicosState();
}

class _ServicosState extends State<Servicos> {
  bool carregando = false;

  List<ServicosModel> servicos = [];

  int servicoSelecionado = 0;

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
      corpo: [
        carregando
            ? const Expanded(child: Center(child: CarregamentoIOS()))
            : Expanded(
                child: servicos.isEmpty
                    ? const Center(child: Text("Nenhum Serviço Cadastrado !"))
                    : ListView.builder(
                        itemBuilder: (context, index) => widget.selecionado
                            ? MouseRegion(
                                cursor: MouseCursor.defer,
                                child: GestureDetector(
                                    onTap: widget.selecionado
                                        ? () {
                                            setState(() => servicoSelecionado =
                                                servicos[index].serCodigo);
                                            widget.selecionarServico!(
                                                servicos[index].serCodigo,
                                                servicos[index].serNome);
                                          }
                                        : null,
                                    child: cardServicos(
                                        cor: servicoSelecionado ==
                                                servicos[index].serCodigo
                                            ? Cores.verdeMedio
                                            : null,
                                        servicos: servicos[index],
                                        context: context)),
                              )
                            : cardServicos(
                                context: context, servicos: servicos[index]),
                      ),
              )
      ],
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
