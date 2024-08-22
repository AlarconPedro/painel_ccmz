import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/pages/pages.dart';

class Participantes extends StatefulWidget {
  const Participantes({super.key});

  @override
  State<Participantes> createState() => _ParticipantesState();
}

class _ParticipantesState extends State<Participantes> {
  String titulo = "Participantes";

  buscarParticipantes() async {}

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: GlobalKey<FormState>(),
      titulo: titulo,
      campos: [],
      gravar: () {},
      cancelar: () {},
    );
  }
}
