// VIEW: tela do formulário. Só desenha a interface e repassa as ações
// do usuário ao ViewModel.
import 'package:flutter/material.dart';
import 'package:simulador_investimentos/views/widgets/cartao_formul%C3%A1rio.dart';
import '../viewmodels/entrada_viewmodel.dart';
import 'tela_resultados.dart';
import 'widgets/campo_numero.dart';

class TelaEntrada extends StatefulWidget {
  const TelaEntrada({super.key});

  @override
  State<TelaEntrada> createState() => _TelaEntradaState();
}

class _TelaEntradaState extends State<TelaEntrada> {
  final _vm = EntradaViewModel();
  final _formKey = GlobalKey<FormState>();

  final _meses = TextEditingController();
  final _capital1 = TextEditingController();
  final _aporte1 = TextEditingController();
  final _taxa1 = TextEditingController();
  final _capital2 = TextEditingController();
  final _aporte2 = TextEditingController();
  final _taxa2 = TextEditingController();

  List<TextEditingController> get _todos =>
      [_meses, _capital1, _aporte1, _taxa1, _capital2, _aporte2, _taxa2];

  @override
  void dispose() {
    for (final c in _todos) {
      c.dispose();
    }
    super.dispose();
  }

  /// Valida o formulário e pede ao ViewModel para simular e navega.
  void _simular() {
    if (!_formKey.currentState!.validate()) return;

    final resultadosVm = _vm.simular(
      meses: _meses.text,
      capital1: _capital1.text,
      aporte1: _aporte1.text,
      taxa1: _taxa1.text,
      capital2: _capital2.text,
      aporte2: _aporte2.text,
      taxa2: _taxa2.text,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TelaResultados(viewModel: resultadosVm)),
    );
  }

  void _limpar() {
    _formKey.currentState!.reset();
    for (final c in _todos) {
      c.clear();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulador de Investimentos'),
        actions: [
          IconButton(
            tooltip: 'Limpar campos',
            icon: const Icon(Icons.refresh),
            onPressed: _limpar,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CartaoFormulario(
                titulo: 'Período (compartilhado)',
                cor: Colors.grey.shade700,
                campos: [
                  CampoNumero(
                    controller: _meses,
                    rotulo: 'Período em meses',
                    icone: Icons.calendar_month,
                    apenasInteiro: true,
                    validator: _vm.validarMeses,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _blocoInvestimento('Investimento 1', Colors.teal, _capital1, _aporte1, _taxa1),
              const SizedBox(height: 12),
              _blocoInvestimento('Investimento 2', Colors.deepOrange, _capital2, _aporte2, _taxa2),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _simular,
                icon: const Icon(Icons.compare_arrows),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text('Comparar investimentos', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _blocoInvestimento(
      String titulo,
      Color cor,
      TextEditingController capital,
      TextEditingController aporte,
      TextEditingController taxa,
      ) {
    return CartaoFormulario(
      titulo: titulo,
      cor: cor,
      campos: [
        CampoNumero(
          controller: capital,
          rotulo: 'Capital inicial',
          prefixo: 'R\$ ',
          icone: Icons.savings,
          validator: _vm.validarDecimal,
        ),
        CampoNumero(
          controller: aporte,
          rotulo: 'Aplicação mensal',
          prefixo: 'R\$ ',
          icone: Icons.add_card,
          validator: _vm.validarDecimal,
        ),
        CampoNumero(
          controller: taxa,
          rotulo: 'Taxa de juros mensal',
          sufixo: '% a.m.',
          icone: Icons.percent,
          validator: _vm.validarDecimal,
        ),
      ],
    );
  }
}
