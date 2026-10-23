/// Formata um valor como moeda brasileira.
String formatarReais(double valor) {
  final negativo = valor < 0;
  final partes = valor.abs().toStringAsFixed(2).split('.');
  final inteiro = partes[0].replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+$)'),
        (m) => '${m[1]}.',
  );
  return '${negativo ? '-' : ''}R\$ $inteiro,${partes[1]}';
}
