// VIEW: tela de resultados. Não faz cálculos: apenas lê o ViewModel e,
// quando ele avisa que mudou (notifyListeners), redesenha com setState.
import 'package:flutter/material.dart';

import '../utils.dart/formatadores.dart';
import '../viewmodels/resultados_viewmodel.dart';
import 'widgets/barra_comparativa.dart';
import 'widgets/cartao_resumo.dart';

class TelaResultados extends StatefulWidget {
  final ResultadosViewModel viewModel;

  const TelaResultados({super.key, required this.viewModel});

  @override
  State<TelaResultados> createState() => _TelaResultadosState();
}

class _TelaResultadosState extends State<TelaResultados> {
  static const _cor1 = Colors.teal;
  static const _cor2 = Colors.deepOrange;

  ResultadosViewModel get vm => widget.viewModel;

  @override
  void initState() {
    super.initState();
    vm.addListener(_aoMudar); // ouve o ViewModel
  }

  @override
  void dispose() {
    vm.removeListener(_aoMudar);
    vm.dispose();
    super.dispose();
  }

  /// Chamado sempre que o ViewModel executa notifyListeners().
  void _aoMudar() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado da Comparação')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        // itens: 0 = resumo | 1 = cabeçalho | 2..meses+1 = linhas dos meses
        itemCount: vm.meses + 2,
        itemBuilder: (context, index) {
          if (index == 0) return _buildResumo();
          if (index == 1) return _buildCabecalhoTabela();
          return _buildLinha(index - 1);
        },
      ),
    );
  }

  Widget _buildResumo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CartaoResumo(
                titulo: 'Investimento 1',
                cor: _cor1,
                resultado: vm.r1,
                destaque: vm.vencedor == 1,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CartaoResumo(
                titulo: 'Investimento 2',
                cor: _cor2,
                resultado: vm.r2,
                destaque: vm.vencedor == 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            vm.mensagemConclusao,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Comparativo do montante final',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        BarraComparativa(
            rotulo: 'Inv. 1', valor: vm.r1.montanteFinal, maximo: vm.maiorMontante, cor: _cor1),
        const SizedBox(height: 6),
        BarraComparativa(
            rotulo: 'Inv. 2', valor: vm.r2.montanteFinal, maximo: vm.maiorMontante, cor: _cor2),
        const SizedBox(height: 16),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Mostrar apenas o rendimento'),
          subtitle: Text(vm.descricaoModo),
          value: vm.mostrarRendimento,
          onChanged: vm.definirMostrarRendimento, // ação enviada ao ViewModel
        ),
        const Text('Evolução mensal',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildCabecalhoTabela() {
    const estilo = TextStyle(fontWeight: FontWeight.bold);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: const Row(
        children: [
          SizedBox(width: 44, child: Text('Mês', style: estilo)),
          Expanded(child: Text('Inv. 1', style: estilo, textAlign: TextAlign.right)),
          Expanded(child: Text('Inv. 2', style: estilo, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _buildLinha(int mes) {
    final v1 = vm.valorInvestimento1(mes);
    final v2 = vm.valorInvestimento2(mes);

    TextStyle estilo(bool maior) => TextStyle(
      fontWeight: maior ? FontWeight.bold : FontWeight.normal,
      color: maior ? Colors.green.shade800 : null,
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: mes.isEven ? Colors.grey.shade100 : null,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          SizedBox(width: 44, child: Text('$mes')),
          Expanded(
            child: Text(formatarReais(v1), textAlign: TextAlign.right, style: estilo(v1 > v2)),
          ),
          Expanded(
            child: Text(formatarReais(v2), textAlign: TextAlign.right, style: estilo(v2 > v1)),
          ),
        ],
      ),
    );
  }
}
