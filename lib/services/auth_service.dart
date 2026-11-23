/// Serviço de Autenticação local (Mock)
/// Aluno: Marcos Luiz Mendes Junior | RA: 1202835-1
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;

  final Map<String, String> _users = {
    'marcos.junior@faculdade.com': '123456',
  };

  bool _isLoggedIn = true; // Pré-autenticado para facilitar a navegação nos prints

  bool get isLoggedIn => _isLoggedIn;

  String? register(String email, String password) {
    final clean = email.trim().toLowerCase();
    if (clean.isEmpty || !clean.contains('@')) return 'Informe um e-mail válido';
    if (password.length < 4) return 'A senha deve ter no mínimo 4 caracteres';
    if (_users.containsKey(clean)) return 'Este e-mail já está cadastrado';

    _users[clean] = password;
    _isLoggedIn = true;
    return null;
  }

  String? login(String email, String password) {
    final clean = email.trim().toLowerCase();
    if (clean.isEmpty || !clean.contains('@')) return 'Informe um e-mail válido';
    if (!_users.containsKey(clean)) return 'Usuário não cadastrado';
    if (_users[clean] != password) return 'Senha incorreta';

    _isLoggedIn = true;
    return null;
  }

  void logout() {
    _isLoggedIn = false;
  }
}