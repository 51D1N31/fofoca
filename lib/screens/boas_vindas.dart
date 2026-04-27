import 'package:flutter/material.dart';
import 'tela_inicial_screen.dart';

class BoasVindasScreen extends StatefulWidget {
  const BoasVindasScreen({super.key});

  @override
  State<BoasVindasScreen> createState() => _BoasVindasScreenState();
}

class _BoasVindasScreenState extends State<BoasVindasScreen> {
  final PageController _pageController = PageController();
  int _paginaAtual = 0;

  final List<Map<String, String>> _conteudo = [
    {
      'titulo': 'Um oceano de fofura espera por você.',
      'imagem': 'assets/elementos/foca_limpo.png',
    },
    {
      'titulo': 'Cuide bem dela! Alimente e mantenha-a feliz.',
      'imagem': 'assets/elementos/foca_comida.png',
    },
    {
      'titulo': 'Personalize com acessórios incríveis!',
      'imagem': 'assets/elementos/foca_chapéu.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/fundo.png', fit: BoxFit.cover),
          ),

          SafeArea(
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 30,
                ),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xffa1c9ff),
                  border: Border.all(width: 4, color: const Color(0xff0047ab)),
                  borderRadius: BorderRadius.zero,
                  boxShadow: const [
                    BoxShadow(color: Colors.black45, offset: Offset(6, 6)),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset('assets/fofoca_texto.png', height: 90),

                    const SizedBox(height: 10),

                    // ÁREA DO CARROSSEL
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() => _paginaAtual = index);
                        },
                        itemCount: _conteudo.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      top: 10,
                                      left: 20,
                                      child: Image.asset(
                                        'assets/elementos/peixinhos.png',
                                        height: 200,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 30,
                                      right: 10,
                                      child: Image.asset(
                                        'assets/elementos/peixinhos.png',
                                        height: 90,
                                      ),
                                    ),

                                    Image.asset(
                                      _conteudo[index]['imagem']!,
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _conteudo[index]['titulo']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff0047ab),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 15),

                    // INDICADOR DE PÁGINAS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _conteudo.length,
                        (index) => Container(
                          margin: const EdgeInsets.all(4),
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color:
                                _paginaAtual == index
                                    ? const Color(0xff0047ab)
                                    : Colors.white,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // BOTÃO COMEÇAR
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff0047ab),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TelaInicialScreen(),
                            ),
                          );
                        },
                        child: const Text('começar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
