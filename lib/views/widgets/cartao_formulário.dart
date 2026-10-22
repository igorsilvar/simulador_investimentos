import 'package:flutter/material.dart';

/// Cartão com título colorido que agrupa os campos de um bloco do formulário.
class CartaoFormulario extends StatelessWidget {
  final String titulo;
  final Color cor;
  final List<Widget> campos;

  const CartaoFormulario({
    super.key,
    required this.titulo,
    required this.cor,
    required this.campos,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titulo,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: cor)),
            const SizedBox(height: 12),
            for (final campo in campos) ...[campo, const SizedBox(height: 12)],
          ],
        ),
      ),
    );
  }
}
