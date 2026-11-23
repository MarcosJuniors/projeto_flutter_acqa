/// Modelo de Usuário desenvolvido por Marcos Luiz Mendes Junior
/// RA: 1202835-1 • ACQA Semana 7 - Prof. Mateus Valente
class UserModel {
  final String name;
  final String email;
  final String password;
  final String ra;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.ra = '1202835-1',
  });
}