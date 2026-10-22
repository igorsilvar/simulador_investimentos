// VIEWMODEL da tela de entrada: validação dos campos e criação da simulação.
// A View só mostra os campos; toda a lógica de conversão/validação fica aqui.
import '../models/investimento.dart';
import 'resultados_viewmodel.dart';

class EntradaViewModel {
  /// Converte texto em número aceitando vírgula ou ponto como decimal.
  double? _lerNumero(String? texto) =>
      double.tryParse((texto ?? '').trim().replaceAll(',', '.'));

  /// Validador para valores decimais não negativos (capital, aporte, taxa).
  String? validarDecimal(String? texto) {
    if (texto == null || texto.trim().isEmpty) return 'Campo obrigatório';
    final n = _lerNumero(texto);
    if (n == null) return 'Digite um número válido';
    if (n < 0) return 'O valor não pode ser negativo';
    return null; // null = campo válido
  }

  /// Validador para o período em meses (inteiro, no mínimo 1).
  String? validarMeses(String? texto) {
    if (texto == null || texto.trim().isEmpty) return 'Campo obrigatório';
    final n = int.tryParse(texto.trim());
    if (n == null) return 'Digite um número inteiro';
    if (n < 1) return 'O valor mínimo é 1';
    return null;
  }

  /// Monta os investimentos a partir dos textos digitados e devolve o
  /// ViewModel da tela de resultados (com os cálculos já feitos).
  /// Só deve ser chamado depois que o formulário foi validado.
  ResultadosViewModel simular({
    required String meses,
    required String capital1,
    required String aporte1,
    required String taxa1,
    required String capital2,
    required String aporte2,
    required String taxa2,
  }) {
    final inv1 = Investimento(
      capitalInicial: _lerNumero(capital1)!,
      aplicacaoMensal: _lerNumero(aporte1)!,
      taxaMensal: _lerNumero(taxa1)!,
    );
    final inv2 = Investimento(
      capitalInicial: _lerNumero(capital2)!,
      aplicacaoMensal: _lerNumero(aporte2)!,
      taxaMensal: _lerNumero(taxa2)!,
    );
    return ResultadosViewModel(inv1: inv1, inv2: inv2, meses: int.parse(meses.trim()));
  }
}
