import 'package:flutter/material.dart';
import '../services/task_service.dart';
import '../theme/app_theme.dart';

/// Tela 4 da Referência: Tela de Calendário
/// Aluno: Marcos Luiz Mendes Junior | RA: 1202835-1
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final _taskService = TaskService();
  late DateTime _selectedDate;
  late DateTime _displayMonth;

  final List<String> _weekDays = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
  final List<String> _monthNames = [
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = _taskService.normalizeDate(now);
    _displayMonth = DateTime(now.year, now.month, 1);
  }

  void _prevMonth() {
    setState(() {
      _displayMonth = DateTime(_displayMonth.year, _displayMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _displayMonth = DateTime(_displayMonth.year, _displayMonth.month + 1, 1);
    });
  }

  void _selectDayAndProceed() {
    Navigator.of(context).pushNamed(
      '/tasks',
      arguments: _selectedDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(_displayMonth.year, _displayMonth.month + 1, 0).day;
    final firstWeekday = DateTime(_displayMonth.year, _displayMonth.month, 1).weekday % 7;

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
                    icon: const Icon(Icons.logout_rounded, color: AppTheme.textPurple),
                    tooltip: 'Sair',
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Card Branco que contém o Calendário
                      Container(
                        padding: const EdgeInsets.all(16),
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
                        child: Column(
                          children: [
                            // Navegação de Mês / Ano
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.chevron_left_rounded, color: AppTheme.textPurple),
                                  onPressed: _prevMonth,
                                ),
                                Text(
                                  '${_monthNames[_displayMonth.month - 1]} ${_displayMonth.year}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.chevron_right_rounded, color: AppTheme.textPurple),
                                  onPressed: _nextMonth,
                                ),
                              ],
                            ),
                            const Divider(),

                            // Cabeçalho dos Dias da Semana
                            Row(
                              children: _weekDays.map((d) {
                                return Expanded(
                                  child: Center(
                                    child: Text(
                                      d,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 8),

                            // Grade dos Dias
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: firstWeekday + daysInMonth,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4,
                                childAspectRatio: 1.0,
                              ),
                              itemBuilder: (context, index) {
                                if (index < firstWeekday) {
                                  return const SizedBox();
                                }

                                final day = index - firstWeekday + 1;
                                final date = DateTime(_displayMonth.year, _displayMonth.month, day);
                                final isSelected = _selectedDate.year == date.year &&
                                    _selectedDate.month == date.month &&
                                    _selectedDate.day == date.day;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedDate = date;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isSelected ? AppTheme.primaryPurple : Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$day',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                          color: isSelected ? Colors.white : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Botão Escuro Tipo Pill: "Selecionar o dia"
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.buttonDark,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: _selectDayAndProceed,
                          child: const Text(
                            'Selecionar o dia',
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
            ),
          ],
        ),
      ),
    );
  }
}