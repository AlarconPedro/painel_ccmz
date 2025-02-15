import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/widgets/form/dropdown_form.dart';

import '../../../classes/classes.dart';
import '../../botoes/btn_primario.dart';

class Esqueleto extends StatelessWidget {
  String tituloPagina;
  String tituloBoto;

  Function() abrirTelaCadastro;
  Function(String busca) buscaNome;

  TextEditingController busca = TextEditingController();

  List<Widget> corpo;

  bool filtro = false;

  String label = "";

  List<DropdownMenuItem<int>> itens = [];

  int selecionado = 0;

  Function? onChange;

  Esqueleto({
    super.key,
    required this.tituloBoto,
    required this.tituloPagina,
    required this.abrirTelaCadastro,
    required this.corpo,
    required this.buscaNome,
    this.filtro = false,
    this.label = "",
    this.itens = const [],
    this.selecionado = 0,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.cinzaClaro,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
                              controller: busca,
                              onSubmitted: (value) async {
                                if (busca.text.isNotEmpty) {
                                  await buscaNome(value);
                                  busca.clear();
                                }
                              },
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: Cores.cinzaEscuro,
                                ),
                              ),
                              placeholder: 'Pesquisar',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CupertinoButton(
                          color: Cores.preto,
                          onPressed: () async {
                            if (busca.text.isNotEmpty) {
                              await buscaNome(busca.text);
                              busca.clear();
                            }
                          },
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          child: const Icon(CupertinoIcons.search),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  filtro
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(children: [
                            Flexible(
                              child: DropDownForm(
                                label: label,
                                itens: itens,
                                selecionado: selecionado,
                                onChange: (value) {
                                  onChange!(value);
                                },
                              ),
                            ),
                            const Spacer(),
                            const Spacer(),
                          ]),
                        )
                      : const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: [
                      Text(
                        tituloPagina,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      btnPrimario(
                          texto: tituloBoto, onPressed: abrirTelaCadastro),
                      // CupertinoButton(
                      //   color: Cores.verdeMedio,
                      //   padding: const EdgeInsets.symmetric(
                      //     vertical: 5,
                      //     horizontal: 30,
                      //   ),
                      //   onPressed: () {
                      //     abrirTelaCadastro();
                      //     // Navigator.push(
                      //     //   context,
                      //     //   CupertinoDialogRoute(
                      //     //     builder: (context) {
                      //     //       return const CadastroPessoas();
                      //     //     },
                      //     //     context: context,
                      //     //   ),
                      //     // );
                      //   },
                      //   child: Text(tituloBoto),
                      // ),
                    ]),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      thickness: 1,
                      color: Cores.preto,
                    ),
                  ),
                  ...corpo,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
