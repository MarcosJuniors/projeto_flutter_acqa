/// Modelo de Tarefa para a ACQA da Semana 7
/// Aluno: Marcos Luiz Mendes Junior | RA: 1202835-1
class TaskModel {
  final String id;
  final String title;
  final DateTime date;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.date,
    this.isCompleted = false, // Por padrão, marcadas como não concluídas!
  });

  TaskModel copyWith({
    String? id,
    String? title,
    DateTime? date,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}