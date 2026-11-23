import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';
import '../theme/app_theme.dart';

/// Tela 5 da Referência: Tela de Lista de Tarefas do Dia
/// Aluno: Marcos Luiz Mendes Junior | RA: 1202835-1
///
/// Regra Obrigatória da ACQA Semana 7:
/// "Importante: as tarefas pendentes devem ser exibidas em primeiro lugar,
/// seguidas das concluídas, ambas em ordem alfabética."
class TaskListScreen extends StatefulWidget {
  final DateTime? initialDate;

  const TaskListScreen({super.key, this.initialDate});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _taskService = TaskService();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? _taskService.normalizeDate(DateTime.now());
  }

  void _openAddTask() {
    Navigator.of(context).pushNamed(
      '/add-task',
      arguments: _selectedDate,
    ).then((_) => setState(() {}));
  }

  void _confirmDelete(TaskModel task) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Remover Tarefa', style: TextStyle(color: AppTheme.textPurple, fontWeight: FontWeight.bold)),
        content: Text('Deseja realmente remover a tarefa "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              shape: const StadiumBorder(),
            ),
            onPressed: () {
              _taskService.removeTask(task.id);
              Navigator.of(ctx).pop();
              setState(() {});
            },
            child: const Text('Remover', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sortedTasks = _taskService.getSortedTasksForDate(_selectedDate);
    final formattedDate = _taskService.formatDate(_selectedDate);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Topo da Imagem de Referência: "Bem Vindo, Marcos!"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bem Vindo,',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPurple,
                        ),
                      ),
                      Text(
                        'Marcos!',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textPurple,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.textPurple),
                    tooltip: 'Voltar ao Calendário',
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: const BoxDecoration(
                  color: AppTheme.primaryPurple,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cabeçalho: "Dia DD/MM/AAAA" (exatamente igual à imagem!)
                    Padding(
                      padding: const EdgeInsets.only(left: 6, bottom: 16),
                      child: Text(
                        'Dia $formattedDate',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Card Branco Central com a Lista de Tarefas
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
                        child: sortedTasks.isEmpty
                            ? const Center(
                                child: Text(
                                  'Nenhuma tarefa para este dia.\nToque no botão + abaixo para adicionar.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black45, fontSize: 14),
                                ),
                              )
                            : ListView.separated(
                                itemCount: sortedTasks.length,
                                separatorBuilder: (_, __) => const Divider(height: 14),
                                itemBuilder: (context, index) {
                                  final task = sortedTasks[index];

                                  return InkWell(
                                    onTap: () {
                                      // Marcar / desmarcar como concluída
                                      _taskService.toggleTaskCompletion(task.id);
                                      setState(() {});
                                    },
                                    borderRadius: BorderRadius.circular(12),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                      child: Row(
                                        children: [
                                          // Indicador visual conforme a imagem de referência:
                                          // Ponto azul para em andamento / Ponto verde para concluída
                                          if (!task.isCompleted)
                                            Container(
                                              width: 14,
                                              height: 14,
                                              margin: const EdgeInsets.only(right: 12),
                                              decoration: const BoxDecoration(
                                                color: AppTheme.taskPendingBlue, // Ponto azul
                                                shape: BoxShape.circle,
                                              ),
                                            )
                                          else
                                            Container(
                                              width: 14,
                                              height: 14,
                                              margin: const EdgeInsets.only(right: 12),
                                              decoration: const BoxDecoration(
                                                color: AppTheme.taskCompletedGreen, // Ponto verde
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(Icons.check, size: 10, color: Colors.white),
                                            ),

                                          // Título da Tarefa
                                          Expanded(
                                            child: Text(
                                              task.title,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: task.isCompleted ? Colors.black45 : Colors.black87,
                                                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                                              ),
                                            ),
                                          ),

                                          // Botão discreto para remover tarefa
                                          IconButton(
                                            icon: const Icon(Icons.delete_outline_rounded, size: 20),
                                            color: Colors.red.shade400,
                                            tooltip: 'Remover tarefa',
                                            onPressed: () => _confirmDelete(task),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Botão Redondo com Ícone "+" no rodapé igual à imagem
                    Center(
                      child: GestureDetector(
                        onTap: _openAddTask,
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.add,
                            color: AppTheme.primaryPurple,
                            size: 34,
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