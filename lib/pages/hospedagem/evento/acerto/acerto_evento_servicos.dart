import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/api/hospedagem/api_evento_despesa.dart';
import 'package:painel_ccmn/pages/hospedagem/evento/acerto/acerto_evento_data.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/botoes/btn_primario.dart';
import 'package:painel_ccmn/widgets/botoes/btn_secundario.dart';
import 'package:painel_ccmn/widgets/separador.dart';
import 'package:painel_ccmn/widgets/snack_notification.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../../../classes/classes.dart';
import '../../../../data/data.dart';
import '../../../financeiro/servicos/servicos.dart';

class AcertoEventoServicos extends StatefulWidget {
  List<AcertoModel> comunidades;
  Function voltarTela;
  int codigoEvento;
  AcertoEventoServicos({
    super.key,
    required this.comunidades,
    required this.voltarTela,
    required this.codigoEvento,
  });

  @override
  State<AcertoEventoServicos> createState() => _AcertoEventoServicosState();
}

class _AcertoEventoServicosState extends State<AcertoEventoServicos> {
  (int, String) servicoSelecionado = (0, "");

  int comunidadeSelecionada = 0;

  bool carregando = false;

  List<DropdownMenuItem> comunidades = [];

  List<String> servicos = [];

  AcertoEventoData acertoEventoData = AcertoEventoData();

  listarComunidadesEvento() async {
    setState(() => carregando = true);
    comunidades.clear();
    comunidades.add(const DropdownMenuItem(value: 0, child: Text("Todos")));
    for (var comunidade in widget.comunidades) {
      comunidades.add(DropdownMenuItem(
          value: comunidade.comCodigo, child: Text(comunidade.comNome)));
    }
    setState(() => carregando = false);
  }

  buscarServicosEvento() async {
    setState(() => carregando = true);
    servicos.clear();
    await acertoEventoData.buscarEventoDespesas(
      codigoEvento: widget.codigoEvento,
      dadosRetorno: (dados) {
        for (var servico in dados) {
          servicos.add(servico.serNome);
        }
      },
      erro: () {
        snackNotification(
            context: context,
            mensage: "Erro ao buscar serviços",
            cor: Cores.vermelhoMedio);
      },
    );
    setState(() => carregando = false);
  }

  @override
  initState() {
    super.initState();
    listarComunidadesEvento();
  }

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: GlobalKey<FormState>(),
      altura: 2.5,
      largura: 1.5,
      titulo: "Serviços do Evento",
      campos: [
        Expanded(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: 300,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  CupertinoDialogRoute(
                                      builder: (context) => selecionarServico(),
                                      // builder: (context) {
                                      //   return Servicos();
                                      //   // return Servicos(
                                      //   //     servicoSelecionado:
                                      //   //         servicoSelecionado,
                                      //   //     onChange: (servico) => setState(
                                      //   //         () => servicoSelecionado =
                                      //   //             servico),
                                      //   //     context: context);
                                      // },
                                      context: context)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Cores.cinzaMedio, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                      child: Text(servicoSelecionado.$2.isEmpty
                                          ? "Selecione o Produto"
                                          : servicoSelecionado.$2)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: DropDownForm(
                              label: "Comunidade",
                              itens: comunidades,
                              selecionado: comunidadeSelecionada,
                              onChange: (valor) =>
                                  setState(() => comunidadeSelecionada = valor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Cores.cinzaClaro,
                    ),
                    child: Expanded(
                      child: servicos.isEmpty
                          ? const Center(child: Text("Nenhum Serviço"))
                          : ListView.builder(
                              itemCount: servicos.length,
                              itemBuilder: (context, index) =>
                                  ListTile(title: Text(servicos[index]))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      gravar: () {},
      cancelar: () => widget.voltarTela(),
    );
  }

  selecionarServico() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 800,
          height: 600,
          decoration: BoxDecoration(
            color: Cores.cinzaClaro,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
            ],
          ),
          child: Column(
            children: [
              Expanded(child: Servicos()),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    btnSecundario(
                        texto: "Fechar",
                        onPressed: () => Navigator.pop(context)),
                    separador(),
                    btnPrimario(
                      texto: "Selecionar",
                      onPressed: () =>
                          Navigator.pop(context, servicoSelecionado),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
