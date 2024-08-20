import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/models/sorteios_model.dart';
import 'package:painel_ccmn/pages/hospedagem/esqueleto/cadastro_form.dart';
import 'package:painel_ccmn/widgets/form/dropdown_form.dart';

import '../../classes/classes.dart';

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

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: formKey,
      largura: 3,
      altura: 2.8,
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
            itens: [],
            selecionado: 0,
            onChange: (value) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: DropDownForm(
            label: "Prémio do Sorteio",
            itens: [],
            selecionado: 0,
            onChange: (value) {},
          ),
        ),
      ],
      titulo: "Novo Sorteio",
      gravar: () {
        Navigator.pop(context, sorteio);
      },
      cancelar: () {},
    );
  }
}
