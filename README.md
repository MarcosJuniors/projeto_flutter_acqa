# Projeto Flutter – Gerenciador de Tarefas Diárias com Calendário

### ACQA (Avaliação Continuada de Questão Aberta) – Semana 7

**Docente:** Prof. Mateus Valente  
**Aluno:** Marcos Luiz Mendes Junior  
**RA:** 1202835-1

---

## 📱 Visão Geral do Aplicativo

Este aplicativo foi desenvolvido utilizando **Flutter e Dart**, com o objetivo de atender aos requisitos propostos na ACQA da Semana 7.

A interface apresenta um design moderno, com paleta de cores roxa vibrante (`#7C2BF8`), cartões brancos e botões com formato arredondado, proporcionando uma experiência visual intuitiva e organizada.

### Funcionalidades Implementadas

**1. Tela de Apresentação e Autenticação (Login e Cadastro)**
- Tela de boas-vindas com identificação do aluno.
- Telas de login e cadastro.
- Alternância entre as telas e validação local dos campos.

**2. Tela de Calendário**
- Navegação entre meses e anos.
- Seleção interativa de datas.
- Botão para acessar as tarefas vinculadas ao dia selecionado.

**3. Tela de Lista de Tarefas**
- Exibição das tarefas associadas à data selecionada.
- Organização das tarefas por status: pendentes primeiro e concluídas depois.
- Ordenação alfabética dentro de cada grupo.
- Possibilidade de marcar e desmarcar tarefas como concluídas.
- Remoção de tarefas com diálogo de confirmação.

**4. Adição de Tarefas**
- Interface para cadastrar novas tarefas.
- Tarefas adicionadas com status pendente por padrão.
- Associação das tarefas à data selecionada.

---

## 🚀 Como Executar o Projeto

1. Abra a pasta do projeto no Android Studio ou Visual Studio Code.
2. No terminal, execute o comando para instalar as dependências:

```bash
flutter pub get
```

3. Inicie o aplicativo em um emulador Android ou dispositivo compatível:

```bash
flutter run
```

---

## 📸 Capturas de Tela da Aplicação

Para a apresentação da ACQA, devem ser disponibilizadas três capturas de tela do aplicativo em execução:

1. **Tela de Login/Cadastro:** apresentação das funcionalidades de autenticação.
2. **Tela do Calendário:** calendário com seleção de uma data.
3. **Tela de Lista de Tarefas:** exibição das tarefas pendentes e concluídas, além da funcionalidade de adição.

---

## 🛠️ Tecnologias Utilizadas

- **Flutter:** framework utilizado no desenvolvimento da interface.
- **Dart:** linguagem de programação utilizada na implementação.
- **Material Design:** componentes e elementos visuais da aplicação.

---

## 📂 Organização do Projeto

- `lib/models/`: modelos de dados utilizados na aplicação.
- `lib/screens/`: telas de apresentação, autenticação, calendário e tarefas.
- `lib/services/`: serviços relacionados à autenticação e ao gerenciamento de tarefas.
- `lib/theme/`: configurações de cores e tema visual.
- `lib/widgets/`: componentes reutilizáveis da interface.
- `test/`: testes automatizados do projeto.

---

## 📤 Repositório

**GitHub:** https://github.com/MarcosJuniors/projeto_flutter_acqa

Este repositório contém os arquivos Dart desenvolvidos para a atividade ACQA da Semana 7.