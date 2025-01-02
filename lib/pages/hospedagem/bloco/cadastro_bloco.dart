import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/pages/pages.dart';

import '../../../classes/classes.dart';

class CadastroBloco extends StatefulWidget {
  BlocoModel? bloco;
  CadastroBloco({super.key, required this.bloco});

  @override
  State<CadastroBloco> createState() => _CadastroBlocoState();
}

class _CadastroBlocoState extends State<CadastroBloco> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();

  bool carregando = false;

  preparaDados() {
    if (widget.bloco != null) {
      return BlocoModel(
        bloCodigo: widget.bloco!.bloCodigo,
        bloNome: nomeController.text,
        qtdLivres: widget.bloco!.qtdLivres,
        qtdOcupados: widget.bloco!.qtdOcupados,
        qtdQuartos: widget.bloco!.qtdQuartos,
      );
    }
    return BlocoModel(
      bloCodigo: 0,
      bloNome: nomeController.text,
      qtdLivres: 0,
      qtdOcupados: 0,
      qtdQuartos: 0,
    );
  }

  gravarBloco() async {
    setState(() => carregando = true);
    var retorno = await ApiBloco().addBloco(preparaDados());
    if (retorno.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Bloco cadastrado com sucesso !"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao cadastrar bloco !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  alualizarBloco() async {
    setState(() => carregando = true);
    var retorno = await ApiBloco().updateBloco(preparaDados());
    if (retorno.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Bloco atualizado com sucesso !"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao atualizar bloco !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.bloco != null) {
      nomeController.text = widget.bloco!.bloNome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: _formKey,
      titulo: "Cadastro de Bloco",
      altura: 4.5,
      largura: 2,
      campos: [
        SizedBox(
          height: 75,
          child: Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: TextFormField(
                controller: nomeController,
                maxLength: 255,
                decoration: const InputDecoration(
                  labelText: 'Nome do bloco',
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
                    return 'Por favor, digite o nome do bloco';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ],
      gravar: () {
        if (_formKey.currentState!.validate()) {
          widget.bloco == null ? gravarBloco() : alualizarBloco();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Cores.vermelhoMedio,
              content: Text("Preencha os campos obrigatórios !"),
            ),
          );
        }
      },
      cancelar: () {
        // Navigator.pop(context);
      },
    );
  }
}
