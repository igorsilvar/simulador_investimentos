import 'package:flutter/material.dart';

/// Campo numérico reutilizável. A regra de validação vem de fora
/// (do ViewModel) pelo parâmetro [validator].
class CampoNumero extends StatelessWidget {
  final TextEditingController controller;
  final String rotulo;
  final IconData icone;
  final String? Function(String?) validator;
  final String? prefixo;
  final String? sufixo;
  final bool apenasInteiro;

  const CampoNumero({
    super.key,
    required this.controller,
    required this.rotulo,
    required this.icone,
    required this.validator,
    this.prefixo,
    this.sufixo,
    this.apenasInteiro = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: !apenasInteiro),
      decoration: InputDecoration(
        labelText: rotulo,
        prefixText: prefixo,
        suffixText: sufixo,
        prefixIcon: Icon(icone),
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
