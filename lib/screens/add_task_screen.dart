import 'package:flutter/material.dart';
import '../services/task_service.dart';
import '../theme/app_theme.dart';

/// Tela 6 da Referência: Tela de Adição de Tarefa
/// Aluno: Marcos Luiz Mendes Junior | RA: 1202835-1
class AddTaskScreen extends StatefulWidget {
  final DateTime? initialDate;

  const AddTaskScreen({super.key, this.initialDate});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _taskService = TaskService();
  final _textController = TextEditingController();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? _taskService.normalizeDate(DateTime.now());
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _saveTask() {
    final title = _textController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, digite o nome da tarefa.')),
      );
      return;
    }

    // Adiciona a tarefa (marcada como não concluída por padrão)
    _taskService.addTask(title, _selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _taskService.formatDate(_selectedDate);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Topo da Imagem de Referência: "Bem Vindo, Marcos!" e "Dia DD/MM/AAAA"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bem Vindo,',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPurple,
                        ),
                      ),
                      const Text(
                        'Marcos!',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textPurple,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Dia $formattedDate',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppTheme.textPurple, size: 28),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Card Roxo Principal da Imagem de Referência
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                decoration: const BoxDecoration(
                  color: AppTheme.primaryPurple,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                ),
                child: Column(
                  children: [
                    // Campo Branco Grande igual à imagem para digitação da tarefa
                    Container(
                      width: double.infinity,
                      height: 180,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _textController,
                        maxLines: 6,
                        autofocus: true,
                        style: const TextStyle(color: Colors.black87, fontSize: 16),
                        decoration: const InputDecoration(
                          hintText: 'Digite o título da tarefa...',
                          hintStyle: TextStyle(color: Colors.black38),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Botão Escuro Tipo Pill: "Adicionar tarefa"
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.buttonDark,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: _saveTask,
                        child: const Text(
                          'Adicionar tarefa',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}