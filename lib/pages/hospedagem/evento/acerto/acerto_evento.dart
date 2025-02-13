import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/data/models/web/hospedagem/servico_evento_model.dart';
import 'package:painel_ccmn/pages/hospedagem/evento/acerto/acerto_evento_data.dart';
import 'package:painel_ccmn/widgets/botoes/btn_mini.dart';
import 'package:painel_ccmn/widgets/botoes/btn_secundario.dart';
import 'package:painel_ccmn/widgets/cards/mostragem/card_despesas_pessoas.dart';
import 'package:painel_ccmn/widgets/separador.dart';
import 'package:painel_ccmn/widgets/snack_notification.dart';

import '../../../../classes/classes.dart';
import '../../../../widgets/botoes/btn_primario.dart';
import '../../../../widgets/botoes/btn_terciario.dart';
import '../../../../widgets/form/campo_texto.dart';
import '../../../../widgets/textos/textos.dart';
import '../../../../widgets/widgets.dart';

class AcertoEvento extends StatefulWidget {
  int codigoEvento;
  String nomeEvento;
  Function mudarPagina;
  List<AcertoModel> comunidades;
  AcertoEvento({
    super.key,
    required this.codigoEvento,
    required this.nomeEvento,
    required this.mudarPagina,
    required this.comunidades,
  });

  @override
  State<AcertoEvento> createState() => _AcertoEventoState();
}

class _AcertoEventoState extends State<AcertoEvento> {
  double alturaFormulario = 530;
  double larguraFormulario = 950;

  double alturaBtnServicos = 50;
  double larguraBtnServicos = 50;

  double alturaBtnProdutos = 50;
  double larguraBtnProdutos = 50;

  double larguraMenuLateral = 260;

  bool carregando = false;
  bool dividirComunidade = false;

  List<DespesasEventoModel> despesasExtra = [];
  List<ServicoEventoModel> eventosDespesas = [];
  List<ServicoEventoModel> produtosDespesas = [];
  List<Map<String, double>> despesasExtraComunidade = [];

  TextEditingController valorCozinhaController = TextEditingController();
  TextEditingController valorHostiariaController = TextEditingController();
  TextEditingController valorhHospedagemController = TextEditingController();

  TextEditingController nomeDespesaController = TextEditingController();
  TextEditingController valorDespesaController = TextEditingController();
  TextEditingController qtdDespesaController = TextEditingController();

  MaskTextInputFormatter valorFormatter = MaskTextInputFormatter(
      mask: '###.###.###.###.###,00', filter: {"#": RegExp(r'[0-9]')});
  double valorTotal = 0;
  double valorTotalServicos = 0;
  double valorOutrasDespesas = 0;
  double valorEvento = 0;
  double valorExtraEvento = 0;
  double valorComunidade = 0;
  double valorPorPessoa = 0;
  double valorHospedagem = 0;
  // double valorCozinha = 0;
  // double valorHostiaria = 0;

  String tipoCobrancaEvento = "";

  int pagantesEvento = 0;
  int cobrantesEvento = 0;

  int codigoComunidade = 0;

  alterarAlturaFormulario() {
    setState(() {
      if (alturaFormulario == 800 && dividirComunidade) {
        alturaFormulario = 530;
      } else {
        alturaFormulario = 800;
      }
    });
  }

  calcularValorTotalComunidade() {
    // double valorTotal = 0;
    // valorTotal += (valorPorPessoa * cobrantesComunidade);
    double valorExtra = 0;
    if (despesasExtra.isNotEmpty) {
      for (var item in despesasExtra) {
        valorExtraEvento += item.dseValor;
      }
    }
    return valorExtra;
  }

  calcularValoresPessoas() {
    valorHospedagem = valorEvento * cobrantesEvento;
    valorhHospedagemController.text = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 2,
    ).format(valorHospedagem);
    //somar todos os valores presentes em serviços e produtos
    double valorServicos = eventosDespesas.isNotEmpty
        ? eventosDespesas
            .map((e) => e.serValor * e.serQuantidade)
            .reduce((value, element) => value + element)
        : 0;
    double valorProdutos = produtosDespesas.isNotEmpty
        ? produtosDespesas
            .map((e) => e.serValor * e.serQuantidade)
            .reduce((value, element) => value + element)
        : 0;
    valorTotalServicos = valorServicos;
    valorOutrasDespesas = valorProdutos;
    valorTotal = valorServicos + valorProdutos + valorHospedagem;
    valorPorPessoa =
        // dividirComunidade ? valorTotal : (valorTotal / pagantesEvento);
        (valorTotal / pagantesEvento);
    valorComunidade =
        // dividirComunidade ? valorPorPessoa : (valorPorPessoa * cobrantesEvento);
        (valorPorPessoa * cobrantesEvento);
    valorExtraEvento = calcularValorTotalComunidade();
    // valorExtraEvento = 0;
  }

  calcularValoresComunidade() {
    valorHospedagem = valorEvento * cobrantesEvento;
    valorhHospedagemController.text = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 2,
    ).format(valorHospedagem);
    double valorServicos = eventosDespesas.isNotEmpty
        ? eventosDespesas
            .map((e) => e.serValor * e.serQuantidade)
            .reduce((value, element) => value + element)
        : 0;
    double valorProdutos = produtosDespesas.isNotEmpty
        ? produtosDespesas
            .map((e) => e.serValor * e.serQuantidade)
            .reduce((value, element) => value + element)
        : 0;
    valorTotalServicos = valorServicos;
    valorOutrasDespesas = valorProdutos;
    valorTotal = valorServicos + valorProdutos + valorHospedagem;
    double valorTotalComunidade = valorHospedagem +
        (eventosDespesas.any((element) => element.serComunidade == 0)
            ? (eventosDespesas
                .where((element) => element.serComunidade == 0)
                .map((e) => e.serValor * e.serQuantidade)
                .reduce((value, element) => value + element))
            : 0) +
        (produtosDespesas.any((element) => element.serComunidade == 0)
            ? (produtosDespesas
                .where((element) => element.serComunidade == 0)
                .map((e) => e.serValor * e.serQuantidade)
                .reduce((value, element) => value + element))
            : 0);
    valorPorPessoa = (valorTotalComunidade / pagantesEvento);
    valorComunidade = (valorPorPessoa * cobrantesEvento);
    // valorExtraEvento = calcularValorTotalComunidade();
  }

  AcertoEventoData acertoEventoData = AcertoEventoData();

  buscarDadosEvento() async {
    setState(() => carregando = true);
    //// Buscar Despesas do Evento
    await acertoEventoData.buscarCustoEvento(
        codigoEvento: widget.codigoEvento,
        dadosRetorno: (dados) {
          valorEvento = dados["eveValor"];
          tipoCobrancaEvento = dados["eveTipoCobranca"];
        },
        erro: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Erro ao buscar despesas do evento"))));
    //// Buscar Despesas Cozinha do Evento
    // await acertoEventoData.buscarCustoCozinha(
    //     codigoEvento: widget.codigoEvento,
    //     dadosRetorno: (dados) {
    //       valorCozinha = double.parse(dados);
    //       valorCozinhaController.text = NumberFormat.currency(
    //         locale: 'pt_BR',
    //         symbol: 'R\$',
    //         decimalDigits: 2,
    //       ).format(valorCozinha);
    //     },
    //     erro: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //         content: Text("Erro ao buscar despesas da cozinha do evento"))));
    //// Buscar Despesas Hostiária do Evento
    // await acertoEventoData.buscarCustoHostiaria(
    //     codigoEvento: widget.codigoEvento,
    //     dadosRetorno: (dados) {
    //       valorHostiaria = double.parse(dados);
    //       valorHostiariaController.text = NumberFormat.currency(
    //         locale: 'pt_BR',
    //         symbol: 'R\$',
    //         decimalDigits: 2,
    //       ).format(valorHostiaria);
    //     },
    //     erro: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //         content: Text("Erro ao buscar despesas da hostiária do evento"))));
    //// Buscar Pagantes e Cobrantes do Evento
    await acertoEventoData.buscarPessoasPagantesCobrantesEvento(
        codigoEvento: widget.codigoEvento,
        dadosRetorno: (dados) {
          pagantesEvento = dados["pagantes"];
          cobrantesEvento = dados["cobrantes"];
        },
        erro: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Erro ao buscar pagantes e cobrantes do evento"))));
    //// Buscar Despesas extra do Evento
    await acertoEventoData.busarDespesasExtraEvento(widget.codigoEvento,
        (dados) {
      for (var item in dados) {
        despesasExtra.add(DespesasEventoModel.fromJson(item));
      }
    }, () {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Erro ao buscar despesas extras do evento")));
    });
    //// Buscar Servicos do Evento
    await acertoEventoData.buscarEventoDespesas(
      codigoEvento: widget.codigoEvento,
      dadosRetorno: (dados) {
        if (dados.isNotEmpty) {
          List<ServicoEventoModel> eventoDespesas = [];
          for (var item in dados) {
            eventoDespesas.add(ServicoEventoModel.fromJson(item));
          }
          // setState(() {
          //TipoDespesa == false ? é servico : é produto
          //Comunidade == 0 ? é Todos : é comunidade
          //CodigoDespesa = Evento || despesa
          produtosDespesas = eventoDespesas
              .where((element) => element.tipoServico == true)
              .toList();
          eventosDespesas = eventoDespesas
              .where((element) => element.tipoServico == false)
              .toList();
          // });
        }
        if (eventosDespesas.any((element) => element.serComunidade != 0)) {
          dividirComunidade = true;
          alterarAlturaFormulario();
          calcularValoresComunidade();
        } else {
          dividirComunidade = false;
          //// Caclular total do evento
          calcularValoresPessoas();
        }
      },
      erro: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erro ao buscar serviços do evento"))),
    );

    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarDadosEvento();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Cores.cinzaClaro,
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: alturaFormulario,
                width: larguraFormulario,
                child: Column(
                  children: [
                    SizedBox(
                      height: 320,
                      child: Center(
                        child: carregando
                            ? const CarregamentoIOS()
                            : Padding(
                                padding: const EdgeInsets.all(10),
                                child: Card(
                                  color: Cores.branco,
                                  elevation: 10,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            color: Cores.azulMedio),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Row(children: [
                                            Textos.textoMedioNormal(
                                                texto:
                                                    "Evento: ${widget.nomeEvento}",
                                                cor: Cores.branco),
                                            const Spacer(),
                                            Textos.textoMedioNormal(
                                                texto:
                                                    "Cobrante: $cobrantesEvento",
                                                cor: Cores.branco),
                                            const SizedBox(width: 10),
                                            Textos.textoMedioNormal(
                                                texto:
                                                    "Pagante: $pagantesEvento",
                                                cor: Cores.branco),
                                            const SizedBox(width: 10)
                                          ]),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: campoTexto(
                                                  titulo: "Valor Hospedagem:",
                                                  dica: "R\$ 0,00",
                                                  icone: CupertinoIcons.house,
                                                  temMascara: false,
                                                  tipo: TextInputType.number,
                                                  mascara:
                                                      CurrencyTextInputFormatter
                                                          .currency(
                                                              locale: "pt_BR",
                                                              symbol: "R\$",
                                                              decimalDigits: 2,
                                                              name: "Real"),
                                                  validador: (validador) {
                                                    if (validador.isEmpty) {
                                                      return 'Por favor, digite o valor da hospedagem';
                                                    }
                                                    return null;
                                                  },
                                                  controlador:
                                                      valorhHospedagemController)),
                                          btnMini(
                                              onPressed: () {
                                                acertoEventoData
                                                    .inserirAtualizarValorHospedagem(
                                                        codigoEvento:
                                                            widget.codigoEvento,
                                                        qtdPessoasCobrantes:
                                                            cobrantesEvento,
                                                        valorHospedagem:
                                                            valorhHospedagemController
                                                                .text,
                                                        dadosRetorno: (dados) {
                                                          snackNotification(
                                                              context: context,
                                                              mensage:
                                                                  "Valor da hospedagem do evento atualizado",
                                                              cor: Cores
                                                                  .verdeMedio);
                                                          buscarDadosEvento();
                                                        },
                                                        erro: () =>
                                                            snackNotification(
                                                                context:
                                                                    context,
                                                                mensage:
                                                                    "Erro ao inserir valor da hospedagem"));
                                              },
                                              child: const Icon(Icons.save,
                                                  color: Cores.branco)),
                                          separador(),
                                          AbsorbPointer(
                                            absorbing: eventosDespesas.any(
                                                (element) =>
                                                    element.serComunidade != 0),
                                            child: Opacity(
                                              opacity: eventosDespesas.any(
                                                      (element) =>
                                                          element
                                                              .serComunidade !=
                                                          0)
                                                  ? 0.5
                                                  : 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Row(
                                                  children: [
                                                    Textos.textoPequeno(
                                                        texto: "Divisão :",
                                                        cor: Cores.preto),
                                                    const SizedBox(width: 10),
                                                    Textos.textoPequeno(
                                                        texto: "Pessoa",
                                                        cor: Cores.preto),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5),
                                                      child: CupertinoSwitch(
                                                          //verificar se o campo serComunidade está diferente de 0
                                                          value:
                                                              dividirComunidade,
                                                          onChanged: (value) {
                                                            alterarAlturaFormulario();
                                                            setState(() =>
                                                                dividirComunidade =
                                                                    value);
                                                            if (dividirComunidade) {
                                                              calcularValoresComunidade();
                                                            } else {
                                                              calcularValoresPessoas();
                                                            }
                                                          }),
                                                    ),
                                                    Textos.textoPequeno(
                                                        texto: "Comunidade",
                                                        cor: Cores.preto),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: SizedBox(
                                              width: 350,
                                              child: btnTerciario(
                                                texto: "Serviços",
                                                onPressed: () =>
                                                    widget.mudarPagina(1),
                                                icon: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    child: Icon(
                                                        CupertinoIcons.wrench,
                                                        size: 30,
                                                        color: Cores.branco)),
                                              ),
                                            ),
                                          ),
                                          separador(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: SizedBox(
                                              width: 350,
                                              child: btnTerciario(
                                                texto: "Outras Despesas",
                                                onPressed: () =>
                                                    widget.mudarPagina(2),
                                                icon: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    child: Icon(
                                                        CupertinoIcons.cube_box,
                                                        size: 30,
                                                        color: Cores.branco)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Textos.textoPequeno(
                                                texto: "Total Serviços:",
                                                cor: Cores.preto),
                                            Textos.textoPequeno(
                                                texto: NumberFormat.currency(
                                                        locale: 'pt_BR',
                                                        symbol: 'R\$',
                                                        decimalDigits: 2)
                                                    .format(valorTotalServicos),
                                                cor: Cores.preto),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Textos.textoPequeno(
                                                texto: "Total Outras Despesas:",
                                                cor: Cores.preto),
                                            Textos.textoPequeno(
                                                texto: NumberFormat.currency(
                                                        locale: 'pt_BR',
                                                        symbol: 'R\$',
                                                        decimalDigits: 2)
                                                    .format(
                                                        valorOutrasDespesas),
                                                cor: Cores.preto),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Textos.textoMedio(
                                                texto: "Total Evento:",
                                                cor: Cores.preto),
                                            Textos.textoMedio(
                                                texto: NumberFormat.currency(
                                                        locale: 'pt_BR',
                                                        symbol: 'R\$',
                                                        decimalDigits: 2)
                                                    .format(valorTotal),
                                                cor: Cores.preto),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Expanded(
                      child: dividirComunidade
                          ? ListView.builder(
                              itemCount: widget.comunidades.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: CardDespesasComunidade(
                                        // valorPorPessoa: valorPorPessoa /
                                        valorPorPessoa: valorPorPessoa,
                                        servicosComunidade: eventosDespesas,
                                        produtosComunidade: produtosDespesas,
                                        pagante: widget.comunidades[index]
                                            .pagantesCobrantes.pagantes,
                                        cobrante: widget.comunidades[index]
                                            .pagantesCobrantes.cobrantes,
                                        codigoComunidade:
                                            widget.comunidades[index].comCodigo,
                                        nomeComunidade:
                                            widget.comunidades[index].comNome));
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: CardDespesasPessoas(
                                  valorPorPessoa: valorPorPessoa,
                                  qtdCobrantes: cobrantesEvento,
                                  qtdComunidades: widget.comunidades.length,
                                  qtdPagantes: pagantesEvento,
                                  valorEvento: valorTotal)),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Cores.branco,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            btnSecundario(
                                texto: "Fechar",
                                onPressed: () => Navigator.pop(context)),
                            btnPrimario(
                                texto: "Gerar",
                                onPressed: () {
                                  acertoEventoData.criarPaginasPDF(
                                    widget.nomeEvento,
                                    valorTotalServicos,
                                    valorOutrasDespesas,
                                    (valorEvento * cobrantesEvento),
                                    valorPorPessoa,
                                    valorTotal,
                                    widget.comunidades,
                                    eventosDespesas,
                                    produtosDespesas,
                                    dividirComunidade,
                                  );
                                },
                                icon: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Icon(CupertinoIcons.printer,
                                        color: Cores.branco))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //TODO: Menu Lateral
            produtosDespesas.isNotEmpty || eventosDespesas.isNotEmpty
                ? AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: alturaBtnProdutos == 50 && alturaBtnServicos == 50
                        ? 50
                        : larguraMenuLateral,
                    height: alturaFormulario,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        eventosDespesas.isNotEmpty
                            ? menuLateral(
                                dados: eventosDespesas
                                    .map((e) => (
                                          e.serNome,
                                          (e.serValor * e.serQuantidade)
                                        ))
                                    .toList(),
                                onPressed: () {
                                  setState(() {
                                    if (alturaBtnServicos == 50) {
                                      if (alturaBtnProdutos ==
                                          (alturaFormulario - 60)) {
                                        alturaBtnProdutos =
                                            ((alturaFormulario / 2) - 5);
                                        larguraBtnProdutos = larguraMenuLateral;
                                        alturaBtnServicos =
                                            ((alturaFormulario / 2) - 5);
                                        larguraBtnServicos = larguraMenuLateral;
                                      } else {
                                        alturaBtnServicos =
                                            alturaFormulario - 60;
                                        larguraBtnServicos = larguraMenuLateral;
                                      }
                                    } else {
                                      if (alturaBtnProdutos > 50) {
                                        alturaBtnProdutos =
                                            alturaFormulario - 60;
                                        larguraBtnProdutos = larguraMenuLateral;
                                      }
                                      alturaBtnServicos = 50;
                                      larguraBtnServicos = 50;
                                    }
                                  });
                                },
                                onHover: (event) {
                                  print("hover");
                                },
                                icone: CupertinoIcons.wrench,
                                altura: alturaBtnServicos,
                                largura: larguraBtnServicos)
                            : const SizedBox(),
                        const SizedBox(height: 10),
                        produtosDespesas.isNotEmpty
                            ? menuLateral(
                                dados: produtosDespesas
                                    .map((e) => (
                                          e.serNome,
                                          (e.serValor * e.serQuantidade)
                                        ))
                                    .toList(),
                                onPressed: () {
                                  setState(() {
                                    if (alturaBtnProdutos == 50) {
                                      if (alturaBtnServicos ==
                                          (alturaFormulario - 60)) {
                                        alturaBtnServicos =
                                            ((alturaFormulario / 2) - 5);
                                        larguraBtnServicos = larguraMenuLateral;
                                        alturaBtnProdutos =
                                            ((alturaFormulario / 2) - 5);
                                        larguraBtnProdutos = larguraMenuLateral;
                                      } else {
                                        alturaBtnProdutos =
                                            alturaFormulario - 60;
                                        larguraBtnProdutos = larguraMenuLateral;
                                      }
                                    } else {
                                      if (alturaBtnServicos > 50) {
                                        alturaBtnServicos =
                                            alturaFormulario - 60;
                                        larguraBtnServicos = larguraMenuLateral;
                                      }
                                      alturaBtnProdutos = 50;
                                      larguraBtnProdutos = 50;
                                    }
                                  });
                                },
                                onHover: (event) {
                                  print("hover");
                                },
                                icone: CupertinoIcons.cube_box,
                                altura: alturaBtnProdutos,
                                largura: larguraBtnProdutos)
                            : const SizedBox(),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  menuLateral(
      {required Function onPressed,
      required Function(PointerHoverEvent evento) onHover,
      IconData? icone,
      required double altura,
      required double largura,
      required List<(String, double)> dados}) {
    List<DataRow> linhas = [];
    linhas.clear();
    for (var item in dados) {
      linhas.add(DataRow(cells: [
        DataCell(Textos.textoMuitoPequeno(texto: item.$1, cor: Cores.branco)),
        DataCell(Textos.textoMuitoPequeno(
            texto: NumberFormat.currency(
                    locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2)
                .format(item.$2),
            cor: Cores.branco)),
      ]));
    }
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) => onHover(event),
      child: GestureDetector(
        onTap: () => onPressed(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          constraints:
              BoxConstraints(maxHeight: alturaFormulario, maxWidth: 250),
          // height: alturaBtnProdutos,
          height: altura,
          // width: larguraBtnProdutos,
          width: largura,
          decoration: BoxDecoration(
              color: Cores.azulMedio, borderRadius: BorderRadius.circular(10)),
          // child: const Icon(CupertinoIcons.cube_box, color: Cores.branco),
          child: altura < ((alturaFormulario / 2) - 30)
              ? Icon(icone, color: Cores.branco)
              //criar uma tabela com duas colunas e 4 linhas e uma linha no rodapé com o total
              : Expanded(
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Textos.textoMedio(
                                texto: "Nome", cor: Cores.branco)),
                        DataColumn(
                            label: Textos.textoMedio(
                                texto: "Valor", cor: Cores.branco)),
                      ],
                      rows: linhas.isNotEmpty
                          ? [...linhas]
                          : [
                              DataRow(cells: [
                                DataCell(Textos.textoMuitoPequeno(
                                    texto: "Sem dados", cor: Cores.branco)),
                                DataCell(Textos.textoMuitoPequeno(
                                    texto: "R\$ 0,00", cor: Cores.branco)),
                              ]),
                              // ? DataRow(cells: [
                              //     DataCell(Textos.textoMuitoPequeno(
                              //         texto: item.item1, cor: Cores.branco)),
                              //     DataCell(Textos.textoMuitoPequeno(
                              //         texto: NumberFormat.currency(
                              //                 locale: 'pt_BR',
                              //                 symbol: 'R\$',
                              //                 decimalDigits: 2)
                              //             .format(item.item2),
                              //         cor: Cores.branco)),
                              //   ])
                              // : DataRow(cells: [
                              //     DataCell(Textos.textoMuitoPequeno(
                              //         texto: "Sem dados", cor: Cores.branco)),
                              //     DataCell(Textos.textoMuitoPequeno(
                              //         texto: "R\$ 0,00", cor: Cores.branco)),
                              //   ]),
                              // DataRow(cells: [
                              //   DataCell(Textos.textoMuitoPequeno(
                              //       texto: "Cozinha", cor: Cores.branco)),
                              //   DataCell(Textos.textoMuitoPequeno(
                              //       texto: NumberFormat.currency(
                              //               locale: 'pt_BR',
                              //               symbol: 'R\$',
                              //               decimalDigits: 2)
                              //           .format(valorCozinha),
                              //       cor: Cores.branco)),
                              //   // DataCell(Text("R\$ 0,00")),
                              // ]),
                              // DataRow(cells: [
                              //   DataCell(Textos.textoMuitoPequeno(
                              //       texto: "Hostiária", cor: Cores.branco)),
                              //   DataCell(Textos.textoMuitoPequeno(
                              //       texto: NumberFormat.currency(
                              //               locale: 'pt_BR',
                              //               symbol: 'R\$',
                              //               decimalDigits: 2)
                              //           .format(valorHostiaria),
                              //       cor: Cores.branco)),
                              //   // DataCell(Text("R\$ 0,00")),
                              // ]),
                              // DataRow(cells: [
                              //   DataCell(Textos.textoMuitoPequeno(
                              //       texto: "Hospedagem", cor: Cores.branco)),
                              //   DataCell(Textos.textoMuitoPequeno(
                              //       texto: NumberFormat.currency(
                              //               locale: 'pt_BR',
                              //               symbol: 'R\$',
                              //               decimalDigits: 2)
                              //           .format(valorHospedagem),
                              //       cor: Cores.branco)),
                              //   // DataCell(Text("R\$ 0,00")),
                              // ]),
                              // DataRow(cells: [
                              //   DataCell(Textos.textoMuitoPequeno(
                              //       texto: "Total", cor: Cores.branco)),
                              //   DataCell(Textos.textoMuitoPequeno(
                              //       texto: NumberFormat.currency(
                              //               locale: 'pt_BR',
                              //               symbol: 'R\$',
                              //               decimalDigits: 2)
                              //           .format(valorTotal),
                              //       cor: Cores.branco)),
                              //   // DataCell(Text("R\$ 0,00")),
                              // ]),
                            ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
