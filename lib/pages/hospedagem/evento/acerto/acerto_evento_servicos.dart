import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:painel_ccmn/data/models/web/hospedagem/servico_evento_model.dart';
import 'package:painel_ccmn/funcoes/funcoes_mascara.dart';
import 'package:painel_ccmn/pages/hospedagem/evento/acerto/acerto_evento_data.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/botoes/btn_primario.dart';
import 'package:painel_ccmn/widgets/botoes/btn_secundario.dart';
import 'package:painel_ccmn/widgets/separador.dart';
import 'package:painel_ccmn/widgets/snack_notification.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../../../classes/classes.dart';
import '../../../../data/data.dart';
import '../../../../data/models/web/hospedagem/evento_despesas_model.dart';
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

  List<DropdownMenuItem> comunidadesListar = [];
  List<Map<int, String>> comunidades = [];

  List<ServicoEventoModel> servicos = [];

  TextEditingController quantidadeServico = TextEditingController();
  TextEditingController valorServico = TextEditingController();

  AcertoEventoData acertoEventoData = AcertoEventoData();

  listarComunidadesEvento() async {
    setState(() => carregando = true);
    comunidadesListar.clear();
    comunidadesListar
        .add(const DropdownMenuItem(value: 0, child: Text("Todos")));
    for (var i = 0; i <= widget.comunidades.length; i++) {
      comunidades.add({0: "Todos"});
      comunidades.add(
          {widget.comunidades[i].comCodigo: widget.comunidades[i].comNome});
      comunidadesListar.add(DropdownMenuItem(
          value: i + 1, child: Text(widget.comunidades[i].comNome)));
    }
    setState(() => carregando = false);
  }

  buscarServicosEvento() async {
    setState(() => carregando = true);
    await acertoEventoData.buscarServicosEvento(
      codigoEvento: widget.codigoEvento,
      dadosRetorno: (dados) {
        servicos.clear();
        for (var servico in dados) {
          servicos.add(ServicoEventoModel.fromJson(servico));
        }
      },
      erro: () {
        snackNotification(
            context: context,
            mensage: "Erro ao buscar serviços",
            cor: Cores.vermelhoMedio);
      },
    );
    // var retorno =
    //     await ApiEventoDespesa().getEventoDespesas(widget.codigoEvento);
    // if (retorno.statusCode == 200) {
    //   // var decoded = json.decode(retorno.body);
    //   for (var servico in retorno) {
    //     servicos.add(ServicoEventoModel.fromJson(servico));
    //   }
    //   // dadosRetorno(json.decode(retorno.body));
    // } else {
    //   snackNotification(
    //       context: context,
    //       mensage: "Erro ao buscar serviços",
    //       cor: Cores.vermelhoMedio);
    //   // erro();
    // }
    setState(() => carregando = false);
  }

  gravarDespesaEvento() async {
    setState(() => carregando = true);
    print(comunidades[comunidadeSelecionada].keys.first);
    await acertoEventoData.inserirDespesaEvento(
      despesa: EventoDespesasModel(
        edpCodigo: 0,
        eveCodigo: widget.codigoEvento,
        edpCodigoDespesa: servicoSelecionado.$1,
        edpQuantidade: int.parse(quantidadeServico.text),
        edpComunidade: comunidadeSelecionada == 0
            ? 0
            : comunidades[comunidadeSelecionada].keys.first,
        edpTipoDespesa: false,
        edpValor: double.parse(valorServico.text
            .replaceAll("R\$", "")
            .replaceAll(".", "")
            .replaceAll(",", ".")),
      ),
      dadosRetorno: (dados) {
        snackNotification(
            context: context,
            mensage: "Despesa inserida com sucesso !",
            cor: Cores.verdeMedio);
        buscarServicosEvento();
      },
      erro: () {
        snackNotification(
            context: context, mensage: "Erro ao inserir despesa !");
      },
    );
    setState(() => carregando = false);
  }

  @override
  initState() {
    super.initState();
    buscarServicosEvento();
    listarComunidadesEvento();
  }

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: GlobalKey<FormState>(),
      altura: 2.3,
      largura: 1.5,
      titulo: "Serviços do Evento",
      campos: [
        Expanded(
          flex: 12,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: 300,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MouseRegion(
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
                                color: servicoSelecionado.$2.isNotEmpty
                                    ? Cores.verdeMedio
                                    : Cores.cinzaClaro,
                                border: Border.all(
                                    color: Cores.cinzaMedio, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  servicoSelecionado.$2.isEmpty
                                      ? "Selecione o Serviço"
                                      : servicoSelecionado.$2,
                                  style: TextStyle(
                                      color: servicoSelecionado.$2.isEmpty
                                          ? Cores.preto
                                          : Cores.branco),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: DropDownForm(
                            label: "Comunidade",
                            itens: comunidadesListar,
                            selecionado: comunidadeSelecionada,
                            onChange: (valor) {
                              setState(() {
                                comunidadeSelecionada = valor;
                              });
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: valorServico,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            CurrencyTextInputFormatter.currency(
                                locale: "pt_BR",
                                symbol: "R\$",
                                decimalDigits: 2,
                                name: "Real"),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Valor',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Cores.cinzaEscuro,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, digite o valor do Evento !';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: quantidadeServico,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: "Quantidade",
                            prefixIcon: const Icon(CupertinoIcons.number),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value!.isEmpty ? "Informe a quantidade" : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Cores.cinzaClaro),
                    child: Expanded(
                      child: servicos.isEmpty
                          ? const Center(child: Text("Nenhum Serviço"))
                          : ListView.builder(
                              itemCount: servicos.length,
                              itemBuilder: (context, index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Cores.branco),
                                    child: ListTile(
                                      title: Text(servicos[index].serNome),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "Valor: ${FuncoesMascara.mascaraDinheiro(servicos[index].serValor)}"),
                                          Text(
                                              "Quantidade: ${servicos[index].serQuantidade}"),
                                          Text(
                                              "Total: ${FuncoesMascara.mascaraDinheiro((servicos[index].serValor * servicos[index].serQuantidade))}"),
                                          const SizedBox()
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(CupertinoIcons.delete,
                                            color: Cores.vermelhoMedio),
                                        onPressed: () => acertoEventoData
                                            .excluirDespesaEvento(
                                                codigoDespesa:
                                                    servicos[index].serCodigo,
                                                dadosRetorno: (dados) {
                                                  snackNotification(
                                                      context: context,
                                                      mensage:
                                                          "Despesa excluída com sucesso !",
                                                      cor: Cores.verdeMedio);
                                                  buscarServicosEvento();
                                                },
                                                erro: () {
                                                  snackNotification(
                                                      context: context,
                                                      mensage:
                                                          "Erro ao excluir despesa !");
                                                }),
                                      ),
                                    ),
                                  )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      gravar: () => gravarDespesaEvento(),
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
              Expanded(
                  child: Servicos(
                selecionado: true,
                selecionarServico: (codigo, nome) =>
                    setState(() => servicoSelecionado = (codigo, nome)),
              )),
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
