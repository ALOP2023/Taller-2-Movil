// import 'package:my_new_project/my_new_project.dart' as my_new_project;
import 'post.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
  Future<List<User>> fetchUsers() async {  
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      List<dynamic> usersJson = jsonDecode(response.body);
      return usersJson.map((json) => User.fromJson(json)).toList();
      } else {
      throw Exception('Failed to load users');
    }
  }
  List<User> filtrarUsuarios(List<User> users) {
    return users.where((user) => user.username.length > 6).toList();
  }
  int contarUsuariosCorreo(List<User> users) {
    return users.where((user) => user.email.endsWith('.biz')).length;
  }
void main() async {
    List<User> users = await fetchUsers();
  for (var user in users) {
    print('ID: ${user.id}, Name: ${user.name}, Username: ${user.username}, Email: ${user.email}');
  }

  // Filtrar usuarios donde nombre de usuario tiene más de 6 caracteres
  List<User> filteredUsers = filtrarUsuarios(users);
  print('Usuarios con nombre de usuario de más de 6 caracteres:');
  for (var user in filteredUsers) {
    print('Username: ${user.username}');
  }

  // Contar usuarios con correos electrónicos del dominio .biz
  int bizDomainCount = contarUsuariosCorreo(users);
  print('\nCantidad de usuarios con correo electrónico del dominio .biz: $bizDomainCount');
}
