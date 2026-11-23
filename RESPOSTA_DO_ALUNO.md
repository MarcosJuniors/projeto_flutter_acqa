# RESPOSTA DO ALUNO - AVALIAÇÃO CONTINUADA DE QUESTÃO ABERTA (ACQA - SEMANA 7)

**Instituição de Ensino Superior**  
**Disciplina:** Desenvolvimento de Aplicações Mobile com Flutter  
**Docente:** Prof. Mateus Valente  
**Aluno:** Marcos Luiz Mendes Junior  
**RA:** 1202835-1  
**Link do Repositório no GitHub:** https://github.com/MarcosJuniors/projeto_flutter_acqa  


---

## 1. INTRODUÇÃO E VISÃO GERAL DO PROJETO

O presente projeto consiste no desenvolvimento de um aplicativo mobile multiplataforma em **Flutter**, concebido para atender integralmente a todos os critérios e funcionalidades estabelecidos na Avaliação Continuada de Questão Aberta (ACQA) da Semana 7.

O aplicativo integra:
1. Telas de **Apresentação do Aluno/RA**, **Login** e **Cadastro** de usuários com validação;
2. Uma tela interativa de **Calendário** que permite navegação mensal e associação de tarefas diárias à data selecionada;
3. Uma tela de **Lista de Tarefas** associada ao dia dinâmico selecionado ("Dia DD/MM/AAAA");
4. Uma tela/diálogo dedicada à **Adição de Tarefas**, onde cada item inserido é, por padrão, marcado como **não concluído** (em andamento);
5. Mecanismo de **conclusão/reabertura** de tarefas e **remoção** com diálogo de segurança;
6. Implementação rigorosa do requisito obrigatório de exibição: **tarefas pendentes são exibidas em primeiro lugar, seguidas pelas concluídas, ambas em ordem alfabética**.

---

## 2. METODOLOGIA E ARQUITETURA DE SOFTWARE

Para assegurar manutenibilidade, testabilidade e respeito às boas práticas de Engenharia de Software, o código-fonte foi estruturado sob o princípio da **Separação de Responsabilidades (Separation of Concerns - SoC)**, dividindo-se em camadas bem definidas dentro do diretório `lib/`:

- **Camada de Apresentação (`lib/screens/` e `lib/widgets/`)**:
  - `welcome_screen.dart`: Tela de boas-vindas exibindo "Bem Vindo, Marcos!" e "MEU RA: 1202835-1".
  - `login_screen.dart` e `register_screen.dart`: Telas de autenticação desenhadas com a identidade visual proposta (ícone checklist estilizado no topo, campos brancos arredondados e botão pílula escuro).
  - `calendar_screen.dart`: Interface de calendário mensal com navegação e seleção do dia.
  - `task_list_screen.dart`: Exibição das tarefas da data selecionada com marcadores azul (em andamento) e verde (concluída).
  - `add_task_screen.dart`: Interface para inserção de novas tarefas com vínculo temporal.
  - `checklist_logo.dart`: Componente visual customizado reproduzindo o ícone da lista com marcadores coloridos.
- **Camada de Domínio e Modelos (`lib/models/`)**:
  - `task_model.dart`: Modela a entidade `TaskModel` (id, title, date, isCompleted).
  - `user_model.dart`: Modela as credenciais e o RA do usuário logado.
- **Camada de Regras de Negócio e Serviços (`lib/services/`)**:
  - `task_service.dart`: Centraliza a manipulação da lista de tarefas, métodos de normalização de datas, alternância de status, deleção e o algoritmo composto de ordenação.
  - `auth_service.dart`: Gerencia a sessão de usuário em memória (mock), dispensando a complexidade e instabilidade de versões de bancos externos (Firebase).
- **Camada de Tema e Estilo (`lib/theme/`)**:
  - `app_theme.dart`: Centraliza a paleta de cores vibrantes, tipografia e estilos de botões.

---

## 3. ESTRUTURAS DE DADOS E ALGORITMOS UTILIZADOS

### 3.1. Normalização Temporal com `DateTime`
Datas em sistemas de informação frequentemente causam inconsistências de chaveamento devido aos componentes de horas, minutos e segundos. Para garantir que tarefas criadas em horários distintos pertençam rigorosamente ao mesmo dia de calendário, implementou-se a normalização:
```dart
DateTime normalizeDate(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}
```
Isso assegura que qualquer comparação diária opere com precisão de data calendário ($O(1)$).

### 3.2. Estrutura de Coleção e Filtragem
As tarefas são armazenadas em uma estrutura de dados de lista dinâmica (`List<TaskModel>`). Para uma data consultada, realiza-se uma operação de filtragem linear via `where()`, gerando o subconjunto de tarefas associadas ao dia.

### 3.3. Algoritmo Composto de Ordenação (Regra Crítica do Professor)
O requisito mandatório estabelece:
> *"Importante: as tarefas pendentes devem ser exibidas em primeiro lugar, seguidas das concluídas, ambas em ordem alfabética."*

Para atender com máxima fidelidade e desempenho, foi desenvolvido um comparador composto binário repassado ao método `.sort()` da lista:

```dart
List<TaskModel> getSortedTasksForDate(DateTime date) {
  final targetDate = normalizeDate(date);
  final dayTasks = _tasks.where((t) => normalizeDate(t.date) == targetDate).toList();

  dayTasks.sort((a, b) {
    // 1º Nível: Precedência booleana (Pendente = false vem antes de Concluída = true)
    if (a.isCompleted != b.isCompleted) {
      return a.isCompleted ? 1 : -1;
    }
    // 2º Nível (Desempate): Ordem léxica alfabética (A-Z) sem distinção de caixa
    return a.title.toLowerCase().compareTo(b.title.toLowerCase());
  });

  return dayTasks;
}
```

#### Análise de Complexidade:
- **Complexidade de Tempo**: O algoritmo utiliza o Timsort nativo do Dart com complexidade média e de pior caso de $\mathcal{O}(N \log N)$, onde $N$ é o número de tarefas do dia.
- **Estabilidade**: Garante que tarefas com títulos iguais mantenham a ordem de inserção relativa, sem variações espúrias na interface.
- **Comportamento Dinâmico**: Ao marcar uma tarefa como realizada, ela é automaticamente reposicionada para o bloco inferior (concluídas) e realinhada alfabeticamente entre suas pares concluídas.

---

## 4. ANÁLISE DE DESIGN, AUTENTICIDADE E USABILIDADE

O design do aplicativo foi desenvolvido com base no layout proposto pelo professor, aplicando princípios modernos de UI/UX e psicologia das cores:
- **Identidade Vibrante**: Uso do tom roxo vibrante (`#7C2BF8`), transmitindo sofisticação, foco e energia criativa, quebrando a monotonia de layouts padrão de listas cinzas.
- **Semiótica dos Marcadores**:
  - Marcador azul circular (`#0088FF`): Representa tarefas ativas/em andamento, atraindo a atenção imediata do usuário.
  - Marcador verde circular com ícone de verificação (`#00C853`): Confirma a conclusão satisfatória da tarefa, acompanhado do efeito tipográfico de tachado (*strikethrough*).
- **Acessibilidade e Ergonomia**: Elementos clicáveis com formato pílula (`StadiumBorder`) em tom escuro (`#130038`) proporcionam alto contraste com o fundo e facilitam o alcance do polegar na navegação em smartphones.
- **Campos de Texto**: Desenhados em cartões brancos com cantos arredondados (`BorderRadius.circular(18)`), garantindo legibilidade imediata das informações preenchidas.

---

## 5. CONCLUSÃO

O desenvolvimento deste projeto consolidou a aplicação prática dos conceitos estudados até a Semana 7, demonstrando o domínio sobre a árvore de Widgets do Flutter, gestão reativa de estado local com `StatefulWidget`, navegação por rotas nomeadas e estruturação algorítmica de coleções. 

A entrega contempla com exatidão a totalidade dos critérios avaliativos: autenticidade visual, código limpo e modular, adição e remoção de tarefas, alternância de status de realização, e a rigorosa ordenação de pendentes e concluídas em ordem alfabética.

**Marcos Luiz Mendes Junior**  
**RA: 1202835-1**