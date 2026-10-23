import 'package:flutter/material.dart';
import '../../utils.dart/formatadores.dart';

/// Barra horizontal proporcional ao valor (comparação visual simples).
class BarraComparativa extends StatelessWidget {
  final String rotulo;
  final double valor;
  final double maximo;
  final Color cor;

  const BarraComparativa({
    super.key,
    required this.rotulo,
    required this.valor,
    required this.maximo,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    final proporcao = maximo <= 0 ? 0.0 : (valor / maximo).clamp(0.0, 1.0);

    return Row(
      children: [
        SizedBox(width: 50, child: Text(rotulo)),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              FractionallySizedBox(
                widthFactor: proporcao,
                child: Container(
                  height: 28,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: cor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    formatarReais(valor),
                    style: const TextStyle(
                        color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
