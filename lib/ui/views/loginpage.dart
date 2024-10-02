import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastrobluecheckapp/color.dart';
import 'package:gastrobluecheckapp/ui/cubit/userlist_cubit.dart';
import 'package:gastrobluecheckapp/ui/cubit/roleconfiglist_cubit.dart';
import 'package:gastrobluecheckapp/ui/middleware/useroperation.dart';
import 'package:gastrobluecheckapp/data/entity/user.dart';
import 'package:gastrobluecheckapp/data/entity/role.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserOperation userOperation = UserOperation();

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Kullanıcıları yükleyelim
    await context.read<UserListCubit>().loadUsers();
    List<User> users = context.read<UserListCubit>().state; // Buradan kullanıcıları alıyoruz
    User? user = users.firstWhere(
          (user) => user.username == username && user.password == password
    );

    if (user != null) {
      // Kullanıcı bulundu, şimdi ilgili rolü yükle
      await context.read<RoleConfigListCubit>().loadRoles();
      List<Role> roles = context.read<RoleConfigListCubit>().state; // Buradan rol listesini alıyoruz
      Role? role = roles.firstWhere((role) => role.id == user.role_id);

      if (role != null) {
        // Kullanıcı ve rol bulundu, giriş işlemini gerçekleştir
        userOperation.loginCheck(username, password, context, _passwordController);
      } else {
        // Rol bulunamadı, hatayı yönet
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kullanıcı için rol bulunamadı: $username")),
        );
      }
    } else {
      // Kullanıcı bulunamadı, hatayı yönet
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Geçersiz kullanıcı adı veya şifre")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          "GASTROBLUE CHECK",
          style: TextStyle(
            color: bigWidgetColor,
            fontFamily: "bebasNeue",
            fontSize: 32,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/gastroblue.png',
              height: 300,
              width: 400,
            ),
            SizedBox(height: 32),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Kullanıcı Adı',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Şifre',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              child: Text('Giriş Yap'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}