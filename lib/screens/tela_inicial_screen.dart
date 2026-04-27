import 'package:flutter/material.dart';
import 'tela_jogo_screen.dart';
import 'tela_cadastro_screen.dart'; // Importação essencial para a navegação

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
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Elementos Decorativos (Peixes e Foca)
                    Positioned(top: 40, right: 200, child: IgnorePointer(child: Image.asset('assets/elementos/peixinhos.png', width: 150))),
                    Positioned(top: 160, left: -10, child: IgnorePointer(child: Image.asset('assets/elementos/peixinhos.png', width: 150))),
                    Positioned(top: 200, right: 15, child: IgnorePointer(child: Image.asset('assets/elementos/peixinhos.png', width: 150))),
                    
                    // Foca centralizada 
                    Positioned(
                      top: -60,
                      left: -80, 
                      child: IgnorePointer(
                        child: Image.asset(
                          'assets/elementos/foca.png',
                          height: 800, 
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // Formulário
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(child: Image.asset('assets/fofoca_texto.png', height: 90)),
                          const SizedBox(height: 240), 
                          
                          _buildLabel('USUÁRIO:'),
                          _buildTextField(_usuarioController, 'seu nome'),
                          
                          const SizedBox(height: 18),
                          
                          _buildLabel('SENHA:'),
                          _buildTextField(_senhaController, '•••••••••', obscure: true),
                          
                          const SizedBox(height: 24),
                          
                          // Botão Entrar
                          SizedBox(
                            height: 55,
                            child: ElevatedButton(
                              style: _pixelButtonStyle(),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const TelaJogoScreen()),
                                );
                              },
                              child: const Text('ENTRAR', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Links Inferiores
                          _buildTextLink('Esqueceu a senha?', () {}),
                          _buildTextLink('Criar conta', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const TelaCadastroScreen()),
                            );
                          }),
                        ],
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

  Widget _buildLabel(String text) => Text(text, style: const TextStyle(color: Color(0xFF003E8A), fontSize: 16, fontWeight: FontWeight.bold));

  Widget _buildTextField(TextEditingController controller, String hint, {bool obscure = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 3), borderRadius: BorderRadius.zero),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF0047AB), width: 3), borderRadius: BorderRadius.zero),
      ),
    );
  }

  ButtonStyle _pixelButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF0047AB),
      foregroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      side: const BorderSide(color: Colors.black, width: 3),
    );
  }

  Widget _buildTextLink(String text, VoidCallback onPress) {
    return TextButton(
      onPressed: onPress,
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF003E8A),
        textStyle: const TextStyle(fontSize: 15, decoration: TextDecoration.underline),
      ),
      child: Text(text),
    );
  }
}