import 'package:flutter/material.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../../classes/classes.dart';
import '../../../data/data.dart';

class CadastroCategorias extends StatefulWidget {
  CategoriaModel? categoria;

  CadastroCategorias({super.key, this.categoria});

  @override
  State<CadastroCategorias> createState() => _CadastroCategoriasState();
}

class _CadastroCategoriasState extends State<CadastroCategorias> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();

  bool carregando = false;

  preparaDados() {
    return CategoriaModel(
      catCodigo: widget.categoria != null ? widget.categoria!.catCodigo : 0,
      catNome: nomeController.text,
    );
  }

  gravarCategoria() async {
    setState(() => carregando = true);
    var retorno = await ApiCategoria().addCategoria(preparaDados());
    if (retorno.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Categoria cadastrada com sucesso !"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao cadastrar categoria !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      titulo: "Cadastro de Categorias",
      formKey: _formKey,
      altura: 4,
      largura: 2.5,
      cancelar: () {
        // Navigator.pop(context);
      },
      gravar: () {
        gravarCategoria();
      },
      campos: [
        carregando
            ? const Expanded(
                child: Center(
                child: CarregamentoIOS(),
              ))
            : Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    controller: nomeController,
                    maxLength: 255,
                    decoration: const InputDecoration(
                      labelText: 'Nome da Categoria',
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
                        return 'Por favor, digite o nome da categoria';
                      }
                      return null;
                    },
                  ),
                ),
              ),
      ],
    );
  }
}
