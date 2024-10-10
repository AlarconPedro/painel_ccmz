import 'package:flutter/material.dart';

import '../pages.dart';

class Formularios extends StatefulWidget {
  const Formularios({super.key});

  @override
  State<Formularios> createState() => _FormulariosState();
}

class _FormulariosState extends State<Formularios> {
  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      abrirTelaCadastro: () {},
      onChange: (index) {},
      buscaNome: (busca) {},
      tituloBoto: 'Novo Formulário',
      tituloPagina: 'Formulários',
      filtro: false,
      label: 'Nome do Formulário',
      selecionado: 0,
      key: key,
      corpo: const [
        Row(children: [
          SizedBox(width: 60),
          Expanded(
            flex: 4,
            child: Text(
              "Nome",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Endereço",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Tipo de Formulário",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 50),
          Expanded(
            flex: 4,
            child: Text(
              "Comunidade",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child:
                Text("Status", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child: Text("Data de Criação",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 15),
          Text("Excluir", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 25),
        ]),
      ],
      itens: const [],
    );
  }
}
