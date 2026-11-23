import '../models/task_model.dart';

/// Serviço de Gerenciamento e Ordenação de Tarefas
/// Aluno: Marcos Luiz Mendes Junior | RA: 1202835-1
///
/// Regra Obrigatória do Prof. Mateus Valente:
/// "Importante: as tarefas pendentes devem ser exibidas em primeiro lugar,
/// seguidas das concluídas, ambas em ordem alfabética."
class TaskService {
  static final TaskService _instance = TaskService._internal();
  factory TaskService() => _instance;

  final List<TaskModel> _tasks = [];

  TaskService._internal() {
    _populateInitialTasks();
  }

  /// Normaliza data para ano/mês/dia (zerando horários)
  DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Formata data no padrão DD/MM/AAAA para exibição nos cabeçalhos
  String formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  /// Adiciona uma nova tarefa à lista (sempre não-concluída por padrão)
  void addTask(String title, DateTime date) {
    final newTask = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      date: normalizeDate(date),
      isCompleted: false, // Por padrão, não concluída!
    );
    _tasks.add(newTask);
  }

  /// Remove tarefa pelo ID
  void removeTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
  }

  /// Alterna status de conclusão (concluída / em andamento)
  void toggleTaskCompletion(String id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    }
  }

  /// Retorna as tarefas da data rigorosamente ordenadas:
  /// 1º: Pendentes primeiro (isCompleted == false)
  /// 2º: Concluídas depois (isCompleted == true)
  /// Ambos os grupos em ordem alfabética de A a Z!
  List<TaskModel> getSortedTasksForDate(DateTime date) {
    final targetDate = normalizeDate(date);
    final dayTasks = _tasks.where((t) => normalizeDate(t.date) == targetDate).toList();

    dayTasks.sort((a, b) {
      // 1º Critério: Pendentes antes de Concluídas
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      // 2º Critério: Ordem alfabética pelo título
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });

    return dayTasks;
  }

  /// Carga inicial para o dia atual com exemplos claros de ordenação
  void _populateInitialTasks() {
    final today = normalizeDate(DateTime.now());

    // Tarefas para hoje:
    // Pendentes em ordem alfabética:
    // 'Apresentar projeto de Flutter' -> 'Comprar livros de Dart' -> 'Estudar Widgets'
    // Concluídas em ordem alfabética:
    // 'Configurar ambiente Android Studio' -> 'Instalar SDK do Flutter'
    _tasks.addAll([
      TaskModel(
        id: '1',
        title: 'Estudar Widgets e Ciclo de Vida',
        date: today,
        isCompleted: false,
      ),
      TaskModel(
        id: '2',
        title: 'Apresentar projeto ao Prof. Mateus',
        date: today,
        isCompleted: false,
      ),
      TaskModel(
        id: '3',
        title: 'Comprar caderno de anotações',
        date: today,
        isCompleted: false,
      ),
      TaskModel(
        id: '4',
        title: 'Instalar SDK do Flutter',
        date: today,
        isCompleted: true,
      ),
      TaskModel(
        id: '5',
        title: 'Configurar ambiente Android Studio',
        date: today,
        isCompleted: true,
      ),
    ]);
  }
}