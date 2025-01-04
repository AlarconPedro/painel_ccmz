import 'package:flutter/material.dart';

class AcertoEventoOutrasDespesas extends StatefulWidget {
  const AcertoEventoOutrasDespesas({super.key});

  @override
  State<AcertoEventoOutrasDespesas> createState() =>
      _AcertoEventoOutrasDespesasState();
}

class _AcertoEventoOutrasDespesasState extends State<AcertoEventoOutrasDespesas>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
