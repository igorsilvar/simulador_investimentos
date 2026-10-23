// VIEWMODEL da tela de resultados: calcula, guarda o estado da tela
import 'package:flutter/foundation.dart';
import '../models/investimento.dart';
import '../utils.dart/formatadores.dart';



class ResultadosViewModel extends ChangeNotifier {
  final int meses;
  final ResultadoSimulacao r1;
  final ResultadoSimulacao r2;

  ResultadosViewModel({
    required Investimento inv1,
    required Investimento inv2,
    required this.meses,
  })  : r1 = ResultadoSimulacao(inv1, meses),
        r2 = ResultadoSimulacao(inv2, meses);

  // ---- Estado da tela ----
  bool _mostrarRendimento = false;
  bool get mostrarRendimento => _mostrarRendimento;

  /// Alterna entre "saldo acumulado" e "apenas rendimento".
  /// notifyListeners() avisa a View para se redesenhar.
  void definirMostrarRendimento(bool valor) {
    _mostrarRendimento = valor;
    notifyListeners();
  }

  // ---- Dados derivados para a View ----
  double get diferenca => (r1.montanteFinal - r2.montanteFinal).abs();
  bool get empate => diferenca < 0.005;

  /// 1 ou 2 (0 em caso de empate).
  int get vencedor => empate ? 0 : (r1.montanteFinal > r2.montanteFinal ? 1 : 2);

  double get maiorMontante =>
      r1.montanteFinal > r2.montanteFinal ? r1.montanteFinal : r2.montanteFinal;

  String get mensagemConclusao => empate
      ? 'Os dois investimentos terminam com o mesmo montante.'
      : 'O Investimento $vencedor rende ${formatarReais(diferenca)} '
      'a mais no período de $meses meses.';

  String get descricaoModo => _mostrarRendimento
      ? 'Exibindo: juros acumulados (sem os aportes)'
      : 'Exibindo: saldo total acumulado';

  /// Valores da tabela no mês [mes], conforme o modo escolhido.
  double valorInvestimento1(int mes) =>
      _mostrarRendimento ? r1.rendimentoNoMes(mes) : r1.saldoNoMes(mes);

  double valorInvestimento2(int mes) =>
      _mostrarRendimento ? r2.rendimentoNoMes(mes) : r2.saldoNoMes(mes);
}
