import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/data/models/web/hospedagem/servicos_model.dart';
import 'package:painel_ccmn/pages/financeiro/servicos/novo_servico.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../../classes/classes.dart';
import '../../../data/api/financeiro/api_servico.dart';
import '../../../widgets/cards/listagem/card_servicos.dart';
import '../../../widgets/snack_notification.dart';

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
    var retorno = await ApiServico().getServicos();
    if (retorno.statusCode == 200) {
      servicos.clear();
      for (var item in json.decode(retorno.body)) {
        servicos.add(ServicosModel.fromJson(item));
      }
    } else {
      if (mounted) {
        snackNotification(
            context: context,
            mensage: "Erro ao Buscar Serviços !",
            cor: Cores.vermelhoMedio);
      }
    }
    setState(() => carregando = false);
    // setState(() => carregando = true);
    // await Servico.buscarServicos().then((value) {
    //   setState(() {
    //     listaServicos = value;
    //     carregando = false;
    //   });
    // });
  }

  excluirServico(int codigoServico) async {
    setState(() => carregando = true);
    var retorno = await ApiServico().deleteServico(codigoServico);
    if (retorno.statusCode == 200) {
      if (mounted) {
        snackNotification(
            context: context, mensage: "Serviço Excluído com Sucesso !");
      }
    } else {
      if (mounted) {
        snackNotification(
            context: context,
            mensage: "Erro ao Excluir Serviço !",
            cor: Cores.vermelhoMedio);
      }
    }
    setState(() => carregando = false);
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
      abrirTelaCadastro: () async {
        await Navigator.push(
            context,
            CupertinoDialogRoute(
                builder: (context) => const NovoServico(), context: context));
        buscarServicos();
      },
      corpo: [
        carregando
            ? const Expanded(child: Center(child: CarregamentoIOS()))
            : Expanded(
                child: servicos.isEmpty
                    ? const Center(child: Text("Nenhum Serviço Cadastrado !"))
                    : ListView.builder(
                        itemCount: servicos.length,
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
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: cardServicos(
                                        excluir: () => excluirServico(
                                            servicos[index].serCodigo),
                                        cor: servicoSelecionado ==
                                                servicos[index].serCodigo
                                            ? Cores.verdeMedio
                                            : null,
                                        servicos: servicos[index],
                                        context: context),
                                  ),
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: cardServicos(
                                    context: context,
                                    servicos: servicos[index],
                                    excluir: () => excluirServico(
                                        servicos[index].serCodigo)),
                              ),
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
