import 'package:flutter/material.dart';
import 'tela_inicial_screen.dart';
import 'inventario_screen.dart';

class TelaJogoScreen extends StatelessWidget {
  const TelaJogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // --- FUNDO (ESPAÇO PARA SUA IMAGEM) ---
          Positioned.fill(
            child: Image.asset(
              'assets/fundo.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.blue.shade900),
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.blue.withValues(alpha: 0.18)),
          ),

          SafeArea(
            child: Stack(
              children: [
                // --- BARRAS DE STATUS (TOPO ESQUERDA) ---
                Positioned(
                  top: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatusBar("FOME", Colors.orange, 0.8),
                      const SizedBox(height: 8),
                      _buildStatusBar("ALEGRIA", Colors.pinkAccent, 0.6),
                      const SizedBox(height: 8),
                      _buildStatusBar("ENERGIA", Colors.yellow, 0.9),
                    ],
                  ),
                ),

                // --- BOTÃO SAIR ---
                Positioned(
                  top: 20,
                  right: 130,
                  child: _buildSquareButton(
                    icon: Icons.logout,
                    label: "SAIR",
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const TelaInicialScreen()),
                      (route) => false,
                    ),
                  ),
                ),

                // --- BOTÃO ROUPAS (INVENTÁRIO) ---
                Positioned(
                  top: 20,
                  right: 20,
                  child: _buildSquareButton(
                    imageAsset: 'assets/elementos/guarda_roupa.png',
                    label: "ROUPAS",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InventarioScreen()),
                    ),
                  ),
                ),

                // --- NAVEGAÇÃO: SETA PARA CIMA (QUARTO) ---
                Positioned(
                  top: size.height * 0.1,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: _ArrowNavigation(
                      label: "QUARTO",
                      turns: 0,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaTeste(titulo: 'QUARTO', cor: Colors.indigo))),
                    ),
                  ),
                ),

                // --- NAVEGAÇÃO: SETA ESQUERDA (BANHEIRO) ---
                Positioned(
                  top: size.height * 0.45,
                  left: 20,
                  child: _ArrowNavigation(
                    label: "BANHEIRO",
                    turns: 3,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaTeste(titulo: 'BANHEIRO', cor: Colors.cyan))),
                  ),
                ),

                // --- NAVEGAÇÃO: SETA DIREITA (COZINHA) ---
                Positioned(
                  top: size.height * 0.45,
                  right: 20,
                  child: _ArrowNavigation(
                    label: "COZINHA",
                    turns: 1,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaTeste(titulo: 'COZINHA', cor: Colors.teal))),
                  ),
                ),

                // --- PERSONAGEM (FOCA) ---
                Positioned(
                  top: size.height * 0.25,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Image.asset(
                      'assets/elementos/foca_limpo.png',
                      height: 250,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.pets, size: 100, color: Colors.white),
                    ),
                  ),
                ),

                // --- ÁREA DE JOGOS (BLOQUEADA) ---
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black, width: 3)),
                          child: const Text("JOGOS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 80,
                          height: 60,
                          color: Colors.brown.shade400,
                          child: const Icon(Icons.lock, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Métodos auxiliares de UI
  Widget _buildStatusBar(String label, Color color, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Container(
          width: 120,
          height: 15,
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black, width: 2)),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(color: color),
          ),
        ),
      ],
    );
  }

  Widget _buildSquareButton({IconData? icon, String? imageAsset, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 85,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black, width: 3)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) Icon(icon, size: 30),
              if (imageAsset != null) Image.asset(imageAsset, height: 30, fit: BoxFit.contain, errorBuilder: (c, e, s) => const Icon(Icons.checkroom)),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- WIDGET DAS SETAS ---
class _ArrowNavigation extends StatelessWidget {
  final String label;
  final int turns;
  final VoidCallback onTap;

  const _ArrowNavigation({required this.label, required this.turns, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          children: [
            RotatedBox(
              quarterTurns: turns,
              child: Image.asset(
                'assets/elementos/seta.png',
                width: 60,
                height: 60,
                errorBuilder: (c, e, s) => const Icon(Icons.arrow_upward, size: 60),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black, width: 2)),
              child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}

// --- TELA DE TESTE PARA AS NAVEGAÇÕES ---
class TelaTeste extends StatelessWidget {
  final String titulo;
  final Color cor;
  const TelaTeste({super.key, required this.titulo, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo), backgroundColor: cor),
      backgroundColor: cor.withValues(alpha: 0.3),
      body: Center(
        child: Text(
          "Bem-vindo ao $titulo",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}