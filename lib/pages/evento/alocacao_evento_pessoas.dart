import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:painel_ccmz/data/data.dart';

import '../../classes/classes.dart';

class AlocacaoEventoPessoas extends StatefulWidget {
  QuartoModel quarto;
  List<String>? pessoas;

  Function removePessoa;

  AlocacaoEventoPessoas({
    super.key,
    required this.quarto,
    this.pessoas,
    required this.removePessoa,
  });

  @override
  State<AlocacaoEventoPessoas> createState() => _AlocacaoEventoPessoasState();
}

class _AlocacaoEventoPessoasState extends State<AlocacaoEventoPessoas> {
  bool carregando = false;

  List<String> pessoasQuarto = [];

  List<Widget> vagasQuarto = [];

  buscarPessoasAlocadas() async {
    setState(() => carregando = true);
    var retorno = await ApiEvento().getPessoasQuarto(widget.quarto.quaCodigo);
    if (retorno.statusCode == 200) {
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          pessoasQuarto.add(PessoaModel.fromJson(item).pesNome);
        });
      }
      for (var pessoa in pessoasQuarto) {
        vagasQuarto.add(
          Row(
            children: [
              const Icon(CupertinoIcons.person),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  pessoa,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.removePessoa(pessoa);
                },
                child: const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Icon(
                    CupertinoIcons.trash,
                    color: Cores.vermelhoMedio,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
    setState(() => carregando = false);
  }

  alimentarPessoasSelecionadas() async {
    setState(() => carregando = true);
    if (widget.pessoas != null) {
      for (var pessoa in widget.pessoas!) {
        vagasQuarto.add(
          Row(
            children: [
              const Icon(CupertinoIcons.person),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  pessoa,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.removePessoa(pessoa);
                },
                child: const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Icon(
                    CupertinoIcons.trash,
                    color: Cores.vermelhoMedio,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
    setState(() => carregando = false);
  }

  alimentarCamasVazias() async {
    setState(() => carregando = true);
    for (var i = 0; i < widget.quarto.quaQtdCamas - vagasQuarto.length; i++) {
      vagasQuarto.add(
        const Row(
          children: [
            Icon(CupertinoIcons.bed_double),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Vazio",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }
    setState(() => carregando = false);
  }

  criarVagas() async {
    await buscarPessoasAlocadas();
    await alimentarPessoasSelecionadas();
    await alimentarCamasVazias();
  }

  @override
  initState() {
    super.initState();
    criarVagas();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 100,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Cores.branco,
        boxShadow: const [
          BoxShadow(
            color: Cores.cinzaMedio,
            blurRadius: 10,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.quarto.quaNome,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ...vagasQuarto,
                  // widget.pessoas != null
                  //     ? Expanded(
                  //         child: ListView.builder(
                  //           itemCount: widget.pessoas!.length,
                  //           itemBuilder: (context, index) {
                  //             return Row(
                  //               children: [
                  //                 const Icon(CupertinoIcons.person),
                  //                 const SizedBox(width: 10),
                  //                 Expanded(
                  //                   child: Text(
                  //                     widget.pessoas![index],
                  //                     style: const TextStyle(
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.bold,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 GestureDetector(
                  //                   onTap: () {
                  //                     widget
                  //                         .removePessoa(widget.pessoas![index]);
                  //                   },
                  //                   child: const MouseRegion(
                  //                     cursor: SystemMouseCursors.click,
                  //                     child: Icon(
                  //                       CupertinoIcons.trash,
                  //                       color: Cores.vermelhoMedio,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             );
                  //           },
                  //         ),
                  //       )
                  //     : const SizedBox(),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: widget.quarto.quaQtdCamaslivres,
                  //     itemBuilder: (context, index) {
                  //       return const Row(
                  //         children: [
                  //           Icon(CupertinoIcons.bed_double),
                  //           SizedBox(width: 10),
                  //           Expanded(
                  //             child: Text(
                  //               "Vazio",
                  //               style: TextStyle(
                  //                 fontSize: 16,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
