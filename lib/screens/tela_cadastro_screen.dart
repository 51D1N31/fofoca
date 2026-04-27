import 'package:flutter/material.dart';
import 'criacao_fofoca_screen.dart'; // Importação da próxima tela

class TelaCadastroScreen extends StatefulWidget {
  const TelaCadastroScreen({super.key});

  @override
  State<TelaCadastroScreen> createState() => _TelaCadastroScreenState();
}

class _TelaCadastroScreenState extends State<TelaCadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  
  bool _aceitouTermos = false;
  bool _receberNotificacoes = true;

  @override
  void dispose() {
    _usuarioController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9BC9FF),
      body: Stack(
        children: [
          // 1. Fundo do oceano
          Positioned.fill(
            child: Image.asset(
              'assets/fundo.png',
              fit: BoxFit.cover,
            ),
          ),
          
          SafeArea(
            child: Center(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFB7D9FF),
                  border: Border.all(color: const Color(0xFF003E8A), width: 4),
                ),
                constraints: BoxConstraints(
                  maxWidth: 420,
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                child: Stack(
                  children: [
                    // 2. O desenho da Foca (posicionada como na tela inicial)
                    Positioned(
                      top: -100,
                      left: -80, 
                      child: IgnorePointer(
                        child: Image.asset(
                          'assets/elementos/foca.png',
                          height: 800, 
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // 3. Conteúdo do Formulário
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(22),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'CADASTRO',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF003E8A),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            
                            // Espaço para a foca não cobrir o título
                            const SizedBox(height: 220), 
                            
                            _buildLabel('USUÁRIO:'),
                            _buildTextFormField(_usuarioController, 'digite seu nome'),
                            
                            const SizedBox(height: 15),
                            
                            _buildLabel('E-MAIL:'),
                            _buildTextFormField(_emailController, 'fofoca@exemplo.com'),
                            
                            const SizedBox(height: 15),

                            // Campo de Senha (conforme solicitado)
                            _buildLabel('SENHA:'),
                            _buildTextFormField(_senhaController, '•••••••••', obscure: true),

                            const SizedBox(height: 20),

                            // Requisito de Coleta: Switch
                            SwitchListTile(
                              title: const Text('Receber avisos de fome', 
                                style: TextStyle(color: Color(0xFF003E8A), fontWeight: FontWeight.bold, fontSize: 14)),
                              value: _receberNotificacoes,
                              activeTrackColor: const Color(0xFF003E8A),
                              onChanged: (bool value) {
                                setState(() { _receberNotificacoes = value; });
                              },
                            ),

                            // Requisito de Coleta: CheckBox
                            CheckboxListTile(
                              title: const Text('Aceito os termos de cuidado', 
                                style: TextStyle(color: Color(0xFF003E8A), fontSize: 13)),
                              value: _aceitouTermos,
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: const Color(0xFF003E8A),
                              onChanged: (bool? value) {
                                setState(() { _aceitouTermos = value ?? false; });
                              },
                            ),

                            const SizedBox(height: 20),

                            // Botão Finalizar (Navega para criacao_fofoca_screen)
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
                                  if (_aceitouTermos) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Bem-vinda ao oceano! 🌊')),
                                    );
                                    
                                    // Navegação para a tela de criação
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const CriacaoFofocaScreen()),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Por favor, aceite os termos.')),
                                    );
                                  }
                                },
                                child: const Text('FINALIZAR', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Voltar', style: TextStyle(color: Color(0xFF003E8A))),
                            ),
                          ],
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

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF003E8A),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String hint, {bool obscure = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0047AB), width: 2),
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }
}