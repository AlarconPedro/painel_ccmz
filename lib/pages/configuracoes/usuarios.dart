import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/models/usuario_model.dart';
import 'package:painel_ccmn/widgets/cards/listagem/card_usuario.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../classes/classes.dart';
import '../../data/api/api_usuario.dart';
import '../pages.dart';
import 'cadastro_usuario.dart';

class Usuarios extends StatefulWidget {
  const Usuarios({super.key});

  @override
  State<Usuarios> createState() => _UsuariosState();
}

class _UsuariosState extends State<Usuarios> {
  bool carregando = false;

  List<UsuarioModel> usuarios = [];

  buscarUsuarios() async {
    setState(() => carregando = true);
    var response = await ApiUsuario().getUsuarios();
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      usuarios.clear();
      setState(() {
        for (var item in decoded) {
          usuarios.add(UsuarioModel.fromJson(item));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar usuários"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  escluirUsuario(int codigoUsuario) async {
    var response = await ApiUsuario().excluirUsuario(codigoUsuario);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuário excluído com sucesso"),
          backgroundColor: Cores.verdeMedio,
        ),
      );
      buscarUsuarios();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao excluir usuário"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Novo Usuário",
      tituloPagina: "Configurações",
      abrirTelaCadastro: () async {
        await Navigator.push(
          context,
          CupertinoDialogRoute(
            builder: (context) => CadastroUsuario(),
            context: context,
          ),
        );
        buscarUsuarios();
      },
      corpo: [
        if (carregando)
          const Expanded(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        else
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      child: CardUsuario(
                        usuario: usuarios[index],
                        excluir: () =>
                            escluirUsuario(usuarios[index].usuCodigo),
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          CupertinoDialogRoute(
                            builder: (context) {
                              return CadastroUsuario(usuario: usuarios[index]);
                            },
                            context: context,
                          ),
                        );
                        buscarUsuarios();
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        // itemCount: usuarios.length,
        // for (var usuario in usuarios)
        // ListTile(
        //   title: Text(usuario.usuEmail),
        //   subtitle: Text(
        //     "Hóspede: ${usuario.usuAcessoHospede ? "Sim" : "Não"}\n"
        //     "Financeiro: ${usuario.usuACessoFinanceiro ? "Sim" : "Não"}\n"
        //     "Estoque: ${usuario.usuAcessoEstoque ? "Sim" : "Não"}",
        //   ),
        // ),
      ],
      buscaNome: (value) {},
    );
  }
}
