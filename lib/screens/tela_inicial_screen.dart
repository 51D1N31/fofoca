import 'package:flutter/material.dart';
import 'tela_jogo_screen.dart';

class TelaInicialScreen extends StatefulWidget {
  const TelaInicialScreen({super.key});

  @override
  State<TelaInicialScreen> createState() => _TelaInicialScreenState();
}

class _TelaInicialScreenState extends State<TelaInicialScreen> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  void dispose() {
    _usuarioController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9BC9FF),
      body: Stack(
        children: [
          // Fundo do oceano
          Positioned.fill(
            child: Image.asset(
              'assets/fundo.png',
              fit: BoxFit.cover,
            ),
          ),

          // Cartão Central
          SafeArea(
            child: Center(
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 420), 
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                clipBehavior: Clip.hardEdge, 
                decoration: BoxDecoration(
                  color: const Color(0xFFB7D9FF), 
                  border: Border.all(color: const Color(0xFF003E8A), width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Camada 1: Peixes ao fundo
                    Positioned(top: 40, right: 200, child: IgnorePointer(child: Image.asset('assets/elementos/peixinhos.png', width: 150))),
                    Positioned(top: 160, left: -10, child: IgnorePointer(child: Image.asset('assets/elementos/peixinhos.png', width: 150))),
                    Positioned(top: 200, right: 15, child: IgnorePointer(child: Image.asset('assets/elementos/peixinhos.png', width: 150))),
                    Positioned(top: 570, right: -30, child: IgnorePointer(child: Image.asset('assets/acessorios/laço.png', width: 200))),
                    // Camada 2: Foca
                    Positioned(
                      top: -60,
                      left: -80, 
                      child: IgnorePointer(
                        child: Image.asset(
                          'assets/elementos/foca.png',
                          height: 800, 
                          fit: BoxFit.contain,
                          alignment: Alignment.centerRight,
                        ),
                      ),
                    ),

                    // Camada 3: Formulário e Logo
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Image.asset('assets/fofoca_texto.png', height: 90),
                          ),
                          
                          // Espaço para a foca aparecer
                          const SizedBox(height: 240), 
                          
                          const Text(
                            'USUÁRIO:',
                            style: TextStyle(
                              color: Color(0xFF003E8A),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _usuarioController,
                            decoration: const InputDecoration(
                              hintText: 'seu nome',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.zero,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF0047AB), width: 3),
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 18),
                          
                          const Text(
                            'SENHA:',
                            style: TextStyle(
                              color: Color(0xFF003E8A),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _senhaController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: '•••••••••',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.zero,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF0047AB), width: 3),
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          SizedBox(
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0047AB),
                                foregroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                side: const BorderSide(color: Colors.black, width: 3),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TelaJogoScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'ENTRAR',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFF003E8A),
                                  textStyle: const TextStyle(fontSize: 15, decoration: TextDecoration.underline),
                                ),
                                child: const Text('Esqueceu a senha?'),
                              ),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFF003E8A),
                                  textStyle: const TextStyle(fontSize: 15, decoration: TextDecoration.underline),
                                ),
                                child: const Text('Criar conta'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Camada 4: Laço
                    Positioned(
                      top: 15, 
                      left: 15, 
                      child: IgnorePointer(
                        child: Image.asset(
                          'assets/acessorios/laço.png',
                          width: 60, 
                        ),
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