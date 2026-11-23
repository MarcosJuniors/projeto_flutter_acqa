import 'package:flutter/material.dart';

/// Paleta e Estilo inspirados no layout de referência da ACQA Semana 7
/// Aluno: Marcos Luiz Mendes Junior | RA: 1202835-1
class AppTheme {
  // Roxo Vibrante idêntico ao modelo da imagem
  static const Color primaryPurple = Color(0xFF7C2BF8); // Roxo vibrante característico
  static const Color primaryDarkPurple = Color(0xFF6200EA);
  static const Color buttonDark = Color(0xFF130038); // Botões escuros tipo pill
  static const Color lightHeaderBg = Color(0xFFEFE8FC); // Topo suave das telas de login
  
  // Cores de status das tarefas
  static const Color taskPendingBlue = Color(0xFF0088FF); // Ponto azul: Tarefa em andamento
  static const Color taskCompletedGreen = Color(0xFF00C853); // Ponto verde: Tarefa concluída

  // Textos
  static const Color textPurple = Color(0xFF4A0E78);
  static const Color textDark = Color(0xFF222222);
  static const Color textWhite = Colors.white;

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryPurple,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'sans-serif',
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryPurple,
        primary: primaryPurple,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonDark,
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}