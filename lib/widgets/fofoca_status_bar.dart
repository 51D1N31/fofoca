import 'package:flutter/material.dart';

class FofocaStatusBar extends StatelessWidget {
  final String label;
  final double percentage; // de 0.0 a 1.0
  final Color fillColor;
  final String iconPath; // Caminho para o ícone (ex: asset da carne/sabão)

  const FofocaStatusBar({
    super.key,
    required this.label,
    required this.percentage,
    required this.fillColor,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Image.asset(iconPath, width: 30, height: 30),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${(percentage * 100).toInt()}%',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Construção da barra com estilo retrô
                Container(
                  height: 15,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ), // Borda pixel art
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: percentage,
                    child: Container(color: fillColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
