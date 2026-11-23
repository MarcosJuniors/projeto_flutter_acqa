import 'package:flutter/material.dart';

/// Ícone estilizado de Checklist igual ao modelo da imagem
/// Aluno: Marcos Luiz Mendes Junior | RA: 1202835-1
class ChecklistLogo extends StatelessWidget {
  final double size;

  const ChecklistLogo({super.key, this.size = 76});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLine(const Color(0xFF7C2BF8), true),
          _buildLine(const Color(0xFFFF4081), false),
          _buildLine(const Color(0xFF00E5FF), false),
        ],
      ),
    );
  }

  Widget _buildLine(Color color, bool isChecked) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: isChecked
              ? const Icon(Icons.check, size: 10, color: Colors.white)
              : null,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: color.withOpacity(0.8),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ],
    );
  }
}