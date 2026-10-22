// Ponto de entrada do app. Só configura o tema e define a tela inicial.
import 'package:flutter/material.dart';

import 'views/tela_entrada.dart';

void main() => runApp(const SimuladorApp());

class SimuladorApp extends StatelessWidget {
  const SimuladorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulador de Investimentos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const TelaEntrada(),
    );
  }
}
