import 'package:flutter_test/flutter_test.dart';
import 'package:task_calendar_app/models/task_model.dart';
import 'package:task_calendar_app/services/task_service.dart';

/// Testes Unitários das Regras Obrigatórias de Negócio
/// Aluno: Marcos Luiz Mendes Junior | RA: 1202835-1
void main() {
  group('Regras de Negócio e Ordenação de Tarefas da ACQA', () {
    late TaskService taskService;
    final testDate = DateTime(2026, 11, 22);

    setUp(() {
      taskService = TaskService();
    });

    test('1. Tarefas devem ser adicionadas por padrão como não concluídas', () {
      taskService.addTask('Nova Tarefa Teste', testDate);
      final tasks = taskService.getSortedTasksForDate(testDate);
      final added = tasks.firstWhere((t) => t.title == 'Nova Tarefa Teste');

      expect(added.isCompleted, isFalse);
    });

    test('2. Tarefas pendentes devem vir primeiro (A-Z) e concluídas depois (A-Z)', () {
      // Cria tarefas desordenadas na inserção:
      // Pendentes: 'Zelar jardim', 'Comprar água'
      // Concluídas: 'Viajar', 'Almoçar'
      taskService.addTask('Zelar jardim', testDate);
      taskService.addTask('Comprar água', testDate);
      taskService.addTask('Viajar', testDate);
      taskService.addTask('Almoçar', testDate);

      // Marca 'Viajar' e 'Almoçar' como concluídas
      final all = taskService.getSortedTasksForDate(testDate);
      for (var t in all) {
        if (t.title == 'Viajar' || t.title == 'Almoçar') {
          taskService.toggleTaskCompletion(t.id);
        }
      }

      final sorted = taskService.getSortedTasksForDate(testDate);
      final pending = sorted.where((t) => !t.isCompleted).map((t) => t.title).toList();
      final completed = sorted.where((t) => t.isCompleted).map((t) => t.title).toList();

      // Verifica se todas as pendentes aparecem antes das concluídas
      int lastPendingIndex = -1;
      int firstCompletedIndex = 999;

      for (int i = 0; i < sorted.length; i++) {
        if (!sorted[i].isCompleted) {
          lastPendingIndex = i;
        } else if (firstCompletedIndex == 999) {
          firstCompletedIndex = i;
        }
      }

      if (completed.isNotEmpty && pending.isNotEmpty) {
        expect(lastPendingIndex < firstCompletedIndex, isTrue);
      }

      // Verifica se as pendentes estão em ordem alfabética
      for (int i = 0; i < pending.length - 1; i++) {
        expect(pending[i].toLowerCase().compareTo(pending[i + 1].toLowerCase()) <= 0, isTrue);
      }

      // Verifica se as concluídas estão em ordem alfabética
      for (int i = 0; i < completed.length - 1; i++) {
        expect(completed[i].toLowerCase().compareTo(completed[i + 1].toLowerCase()) <= 0, isTrue);
      }
    });

    test('3. Marcar como concluída e remover tarefas da lista', () {
      taskService.addTask('Tarefa Temporária', testDate);
      final tasks = taskService.getSortedTasksForDate(testDate);
      final task = tasks.firstWhere((t) => t.title == 'Tarefa Temporária');

      expect(task.isCompleted, isFalse);

      // Alterna para concluída
      taskService.toggleTaskCompletion(task.id);
      final updatedTasks = taskService.getSortedTasksForDate(testDate);
      final updated = updatedTasks.firstWhere((t) => t.id == task.id);
      expect(updated.isCompleted, isTrue);

      // Remove a tarefa
      taskService.removeTask(task.id);
      final afterDelete = taskService.getSortedTasksForDate(testDate);
      expect(afterDelete.any((t) => t.id == task.id), isFalse);
    });
  });
}