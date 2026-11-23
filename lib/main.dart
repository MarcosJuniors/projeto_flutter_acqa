import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/task_list_screen.dart';
import 'screens/add_task_screen.dart';
import 'theme/app_theme.dart';

/// Ponto de Entrada da Aplicação Flutter
/// 
/// Aluno: Marcos Luiz Mendes Junior
/// RA: 1202835-1
/// Disciplina: Programação Mobile - ACQA Semana 7
/// Docente: Prof. Mateus Valente
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TaskCalendarApp());
}

class TaskCalendarApp extends StatelessWidget {
  const TaskCalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskCalendar • Marcos Luiz Mendes Junior (RA: 1202835-1)',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/tasks') {
          final dateArg = settings.arguments as DateTime?;
          return MaterialPageRoute(
            builder: (context) => TaskListScreen(initialDate: dateArg),
          );
        }
        if (settings.name == '/add-task') {
          final dateArg = settings.arguments as DateTime?;
          return MaterialPageRoute(
            builder: (context) => AddTaskScreen(initialDate: dateArg),
          );
        }
        return null;
      },
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/calendar': (context) => const CalendarScreen(),
      },
    );
  }
}