import 'package:flutter/material.dart';
import '../models/acessorio.dart';
import '../utils/fofoca_feedbacks.dart';

class InventarioScreen extends StatelessWidget {
  const InventarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Supondo que você tenha a listaAcessorios importada
    final inventario = listaAcessorios;

    return Scaffold(
      backgroundColor: const Color(0xffa1c9ff),
      appBar: AppBar(
        title: const Text(
          'GUARDA-ROUPA',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff0047ab),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 itens por linha
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: inventario.length,
          itemBuilder: (context, index) {
            final item = inventario[index];
            return GestureDetector(
              onTap: () {
                // Chama a função que você criou ali em cima!
                FofocaFeedbacks.mostrarDialogoConfirmacao(
                  context: context,
                  titulo: 'EQUIPAR',
                  pergunta: 'Deseja colocar ${item.nome} na Fofoca?',
                  onConfirm: () {
                    FofocaFeedbacks.mostrarNotificacao(
                      context,
                      '${item.nome} equipado!',
                    );
                    // Aqui entra a lógica de trocar o item no mascote
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/acessorios/${item.nome.toLowerCase()}.png',
                      height: 40,
                    ),
                    const SizedBox(height: 5),
                    Text(item.nome, style: const TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
