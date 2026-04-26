import 'package:flutter/material.dart';

class FofocaFeedbacks {
  // Feedback rápido estilo Tamagotchi (SnackBar)
  static void mostrarNotificacao(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          mensagem,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.yellow, // Cor base do tema de vocês
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 3), // Borda grossa
          borderRadius: BorderRadius.zero, // Quadrado
        ),
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Pop-up contextual (Dialog)
  static void mostrarDialogoConfirmacao({
    required BuildContext context,
    required String titulo,
    required String pergunta,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            backgroundColor: const Color(0xffa1c9ff), // Cor de fundo do app
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Color(0xff0047ab), width: 4),
              borderRadius: BorderRadius.zero,
            ),
            title: Text(
              titulo,
              style: const TextStyle(color: Color(0xff0047ab)),
            ),
            content: Text(pergunta),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('NÃO', style: TextStyle(color: Colors.red)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  onConfirm();
                },
                child: const Text('SIM'),
              ),
            ],
          ),
    );
  }
}
