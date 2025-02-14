import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/widgets/listas/listar_dados.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../classes/classes.dart';
import '../botoes/btn_primario.dart';

Widget modeloListagemCadastro({
  required Function fncBusca,
  required Function fncAbrirCadastro,
  required TextEditingController ctlrBusca,
  Widget? filtros,
  required List<dynamic> listaDados,
  required Function(dynamic dado) cardListagem,
  required Row tituloColunas,
  required String titulo,
  required String btnTitulo,
  required bool carregando,
  required BuildContext context,
}) {
  return Scaffold(
    backgroundColor: Cores.cinzaClaro,
    body: Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 10,
          color: Cores.branco,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Cores.branco,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Buscar: ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 55,
                          child: CupertinoTextField(
                            controller: ctlrBusca,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Cores.cinzaEscuro),
                            ),
                            placeholder: 'Pesquisar',
                            onSubmitted: (value) async {
                              await fncBusca(value);
                              // ctlrBusca.clear();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      CupertinoButton(
                        color: Cores.preto,
                        onPressed: () async {
                          if (ctlrBusca.text != "") {
                            await fncBusca(ctlrBusca.text);
                          }
                        },
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: const Icon(CupertinoIcons.search),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                filtros ?? const SizedBox(),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    Text(titulo,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    btnPrimario(
                        onPressed: () async => await fncAbrirCadastro(),
                        texto: btnTitulo),
                    // CupertinoButton(
                    //     color: Cores.verdeMedio,
                    //     padding: const EdgeInsets.symmetric(
                    //       vertical: 5,
                    //       horizontal: 30,
                    //     ),
                    //     onPressed: () => fncAbrirCadastro(),
                    //     child: Text(btnTitulo)),
                  ]),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(thickness: 1, color: Cores.preto),
                ),
                tituloColunas,
                carregando
                    ? const Expanded(child: Center(child: CarregamentoIOS()))
                    : listarDados(
                        dados: listaDados,
                        cardListagem: (dado) => cardListagem(dado),
                        textoVazio: "Nenhum dado encontrado"),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
