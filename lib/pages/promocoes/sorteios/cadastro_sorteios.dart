import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/models/sorteios_model.dart';
import 'package:painel_ccmn/pages/hospedagem/esqueleto/cadastro_form.dart';
import 'package:painel_ccmn/widgets/form/dropdown_form.dart';

import '../../../classes/classes.dart';
import '../../../data/api/promocao/api_promocao.dart';
import '../../../data/models/web/promocoes/sorteio_model.dart';
import '../../../models/promocoes_model.dart';

class CadastroSorteio extends StatefulWidget {
  SorteiosModel? sorteio;
  CadastroSorteio({super.key, this.sorteio});

  @override
  State<CadastroSorteio> createState() => _CadastroSorteioState();
}

class _CadastroSorteioState extends State<CadastroSorteio> {
  final formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();

  SorteiosModel sorteio = SorteiosModel(
    sorCodigo: 0,
    sorNome: '',
    sorData: '',
    sorNomeGanhador: '',
  );

  int promocaoSelecionada = 0;
  int premioSelecionado = 0;

  List<DropdownMenuItem> promocoes = [];

  bool carregando = false;

  buscarPromocoes() async {
    var retorno = await ApiPromocao().getPromocoes("V");
    if (retorno.statusCode == 200) {
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(
          () => promocoes.add(
            DropdownMenuItem(
              value: item['proCodigo'],
              child: Text(item['proNome']),
            ),
          ),
        );
      }
    }
  }

  buscarPremios(int codigoPromocao) async {
    var retorno = await ApiPromocao().getPremiosPromocao(codigoPromocao);
    if (retorno.statusCode == 200) {
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(
          () => promocoes.add(
            DropdownMenuItem(
              value: item['PreCodigo'],
              child: Text(item['PreNome']),
            ),
          ),
        );
      }
    }
  }

  SorteioModel preparaDados() {
    return SorteioModel(
      sorCodigo: 0,
      cupCodigo: 0,
      parCodigo: 0,
      sorData: DateTime.now().toString(),
      proCodigo: promocaoSelecionada,
      preCodigo: premioSelecionado,
    );
  }

  gravarSorteio() async {
    setState(() => carregando = true);
    dynamic retorno = await ApiPromocao().addSorteioPromocao(preparaDados());
    if (retorno.statusCode == 200) {
      Navigator.pop(
        context,
        SorteiosModel(
          sorCodigo: 0,
          sorNome: nomeController.text,
          sorData: DateTime.now().toString(),
          sorNomeGanhador: nomeController.text,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sorteio cadastrado com sucesso!'),
          backgroundColor: Cores.verdeMedio,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao cadastrar o Sorteio!'),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarPromocoes();
  }

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: formKey,
      largura: 3,
      altura: 2.6,
      campos: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: TextFormField(
            controller: nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome',
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
                return 'Por favor, digite o Nome do Sorteio';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: DropDownForm(
            label: "Promoção do Sorteio",
            itens: promocoes,
            selecionado: promocaoSelecionada,
            onChange: (value) {
              setState(() {
                promocaoSelecionada = value;
                buscarPremios(value);
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: DropDownForm(
            label: "Prémio do Sorteio",
            itens: const [],
            selecionado: premioSelecionado,
            onChange: (value) {
              setState(() {
                premioSelecionado = value;
              });
            },
          ),
        ),
      ],
      titulo: "Novo Sorteio",
      gravar: () {
        gravarSorteio();
      },
      cancelar: () {},
    );
  }
}
