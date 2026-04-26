import 'package:flutter/material.dart';
import '../widgets/fofoca_status_bar.dart';
import '../utils/fofoca_feedbacks.dart';
import 'inventario_screen.dart'; // Sua tela de guarda-roupa

class TelaTesteScreen extends StatefulWidget {
  final String nomeFofoca;

  const TelaTesteScreen({super.key, required this.nomeFofoca});

  @override
  State<TelaTesteScreen> createState() => _TelaTesteScreenState();
}

class _TelaTesteScreenState extends State<TelaTesteScreen> {
  // Simulando o estado da sua Fofoca
  double _fome = 0.85;
  double _alegria = 0.70;

  void _alimentarFofoca() {
    setState(() {
      _fome = (_fome + 0.1).clamp(0.0, 1.0); // Aumenta a barra até 100%
    });
    FofocaFeedbacks.mostrarNotificacao(
      context,
      '${widget.nomeFofoca} comeu um plâncton gostoso!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffa1c9ff),
      appBar: AppBar(
        title: Text('Testando: ${widget.nomeFofoca}'),
        backgroundColor: const Color(0xff0047ab),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 1. Suas Barras de Status
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Column(
                children: [
                  FofocaStatusBar(
                    label: 'FOME',
                    percentage: _fome,
                    fillColor: Colors.green,
                    iconPath:
                        'assets/fofoca_texto.png', // Troque pelo ícone real depois
                  ),
                  FofocaStatusBar(
                    label: 'ALEGRIA',
                    percentage: _alegria,
                    fillColor: Colors.yellow,
                    iconPath:
                        'assets/fofoca_texto.png', // Troque pelo ícone real depois
                  ),
                ],
              ),
            ),

            const Spacer(),

            // 2. Botões para testar seus Feedbacks
            ElevatedButton(
              onPressed: _alimentarFofoca,
              child: const Text('Testar SnackBar (Alimentar)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                FofocaFeedbacks.mostrarDialogoConfirmacao(
                  context: context,
                  titulo: 'DORMIR',
                  pergunta: 'Deseja colocar ${widget.nomeFofoca} para dormir?',
                  onConfirm: () {
                    FofocaFeedbacks.mostrarNotificacao(context, 'Zzzzz...');
                  },
                );
              },
              child: const Text('Testar Dialog (Dormir)'),
            ),

            const Spacer(),

            // 3. Botão para ir para o seu Inventário
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InventarioScreen(),
                    ),
                  );
                },
                child: const Text(
                  'ABRIR GUARDA-ROUPA',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
