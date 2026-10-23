import 'package:flutter/material.dart';
import '../../models/investimento.dart';
import '../../utils.dart/formatadores.dart';

/// Cartão com montante final, total investido e rendimento de um investimento.
class CartaoResumo extends StatelessWidget {
  final String titulo;
  final Color cor;
  final ResultadoSimulacao resultado;
  final bool destaque;

  const CartaoResumo({
    super.key,
    required this.titulo,
    required this.cor,
    required this.resultado,
    required this.destaque,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: destaque ? 6 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: cor, width: destaque ? 2.5 : 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(titulo,
                      style: TextStyle(fontWeight: FontWeight.bold, color: cor)),
                ),
                if (destaque)
                  Icon(Icons.emoji_events, color: Colors.amber.shade700, size: 20),
              ],
            ),
            const Divider(),
            _linha('Montante final', formatarReais(resultado.montanteFinal), negrito: true),
            const SizedBox(height: 8),
            _linha('Total investido', formatarReais(resultado.totalInvestido)),
            const SizedBox(height: 8),
            _linha('Rendimento total', formatarReais(resultado.rendimentoTotal),
                corValor: Colors.green.shade800),
          ],
        ),
      ),
    );
  }

  Widget _linha(String rotulo, String valor, {bool negrito = false, Color? corValor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(rotulo, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(valor,
            style: TextStyle(
              fontSize: negrito ? 16 : 14,
              fontWeight: negrito ? FontWeight.bold : FontWeight.w500,
              color: corValor,
            )),
      ],
    );
  }
}
