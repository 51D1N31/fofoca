import 'package:flutter/material.dart';
import 'tela_inicial_screen.dart';
import 'inventario_screen.dart';

class TelaJogoScreen extends StatefulWidget {
  const TelaJogoScreen({super.key});

  @override
  State<TelaJogoScreen> createState() => _TelaJogoScreenState();
}

class _TelaJogoScreenState extends State<TelaJogoScreen> {
  int _indiceAtual = 0; // Controla qual aba está ativa

  // Lista de páginas que serão exibidas no corpo (body) do Scaffold
  late final List<Widget> _paginas;

  @override
  void initState() {
    super.initState();
    _paginas = [
      const OceanoPrincipal(), // Aba 0: Sua tela principal atual
      const TelaTeste(titulo: 'QUARTO', cor: Colors.indigo),   // Aba 1
      const TelaTeste(titulo: 'BANHEIRO', cor: Colors.cyan),   // Aba 2
      const TelaTeste(titulo: 'COZINHA', cor: Colors.teal),    // Aba 3
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // O corpo da tela muda dependendo do índice selecionado
      body: _paginas[_indiceAtual],

      // Implementação da BottomNavigationBar 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (index) {
          setState(() {
            _indiceAtual = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF003E8A),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'OCEANO'),
          BottomNavigationBarItem(icon: Icon(Icons.bed), label: 'QUARTO'),
          BottomNavigationBarItem(icon: Icon(Icons.hot_tub), label: 'BANHEIRO'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'COZINHA'),
        ],
      ),
    );
  }
}

// --- WIDGET DO OCEANO PRINCIPAL
class OceanoPrincipal extends StatelessWidget {
  const OceanoPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/fundo.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(color: Colors.blue.shade900),
          ),
        ),
        SafeArea(
          child: Stack(
            children: [
              // BARRAS DE STATUS
              Positioned(
                top: 20,
                left: 20,
                child: Column(
                  children: [
                    _buildStatusBar("FOME", Colors.orange, 0.8),
                    const SizedBox(height: 8),
                    _buildStatusBar("ALEGRIA", Colors.pinkAccent, 0.6),
                    const SizedBox(height: 8),
                    _buildStatusBar("ENERGIA", Colors.yellow, 0.9),
                  ],
                ),
              ),
              
              // BOTÕES DE AÇÃO (SAIR E ROUPAS)
              Positioned(
                top: 20,
                right: 20,
                child: Row(
                  children: [
                    _buildSquareButton(
                      icon: Icons.logout,
                      label: "SAIR",
                      onTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const TelaInicialScreen()),
                        (route) => false,
                      ),
                    ),
                    const SizedBox(width: 10),
                    _buildSquareButton(
                      imageAsset: 'assets/elementos/guarda_roupa.png',
                      label: "ROUPAS",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const InventarioScreen()),
                      ),
                    ),
                  ],
                ),
              ),

              // PERSONAGEM CENTRAL
              Center(
                child: Image.asset(
                  'assets/elementos/foca_limpo.png',
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Métodos auxiliares de UI (Mantidos do seu código original)
  Widget _buildStatusBar(String label, Color color, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
        Container(
          width: 120, height: 15,
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
      child: Container(
        width: 70,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black, width: 2)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon, size: 20),
            if (imageAsset != null) Image.asset(imageAsset, height: 20),
            Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class TelaTeste extends StatelessWidget {
  final String titulo;
  final Color cor;
  const TelaTeste({super.key, required this.titulo, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo), 
        backgroundColor: cor,
      ),
      // Ajuste para versões mais recentes do Flutter
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