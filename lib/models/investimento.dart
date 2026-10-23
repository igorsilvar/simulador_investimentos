/// Guarda os dados de um investimento e calcula a sua evolução.
class Investimento {
  final double capitalInicial;
  final double aplicacaoMensal;
  final double taxaMensal; // em %, ex.: 1.5 significa 1,5% ao mês

  const Investimento({
    required this.capitalInicial,
    required this.aplicacaoMensal,
    required this.taxaMensal,
  });

  List<double> calcularEvolucao(int meses) {
    final taxa = taxaMensal / 100;
    final saldos = <double>[capitalInicial];
    double saldo = capitalInicial;

    for (int mes = 1; mes <= meses; mes++) {
      saldo = saldo * (1 + taxa) + aplicacaoMensal;
      saldos.add(saldo);
    }
    return saldos;
  }

  /// Total efetivamente colocado pelo investidor até o mês [mes].
  double totalInvestidoAte(int mes) => capitalInicial + aplicacaoMensal * mes;
}

/// Resultado da simulação de um investimento.
class ResultadoSimulacao {
  final Investimento investimento;
  final List<double> evolucao;

  ResultadoSimulacao(this.investimento, int meses)
      : evolucao = investimento.calcularEvolucao(meses);

  int get meses => evolucao.length - 1;
  double get montanteFinal => evolucao.last;
  double get totalInvestido => investimento.totalInvestidoAte(meses);
  double get rendimentoTotal => montanteFinal - totalInvestido;

  /// Saldo acumulado no mês [mes].
  double saldoNoMes(int mes) => evolucao[mes];

  /// Apenas os juros acumulados até o mês [mes] (saldo menos o que foi aportado).
  double rendimentoNoMes(int mes) =>
      evolucao[mes] - investimento.totalInvestidoAte(mes);
}
