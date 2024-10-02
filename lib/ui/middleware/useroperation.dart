import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastrobluecheckapp/color.dart';
import 'package:gastrobluecheckapp/ui/views/homepage.dart';
import 'package:gastrobluecheckapp/ui/views/loginpage.dart';
import 'package:gastrobluecheckapp/data/entity/user.dart';
import 'package:gastrobluecheckapp/data/entity/role.dart';
import 'package:gastrobluecheckapp/ui/cubit/userlist_cubit.dart';
import 'package:gastrobluecheckapp/ui/cubit/roleconfiglist_cubit.dart';

class UserOperation {
  late Role userRole; // Kullanıcının rol bilgilerini tutacak değişken

  // Kullanıcı giriş kontrolü
  Future<void> loginCheck(String username, String password, BuildContext context, TextEditingController passwordController) async {
    // Kullanıcı listesini yükle
    await context.read<UserListCubit>().loadUsers();
    List<User> users = context.read<UserListCubit>().state; // Kullanıcı listesini al

    // Kullanıcıyı bul
    User? user = users.firstWhere(
          (user) => user.username == username && user.password == password // Kullanıcı bulunamazsa null döner
    );

    if (user != null) {
      // Kullanıcının rolünü yükle
      Role? role = await context.read<RoleConfigListCubit>().loadRoleById(user.role_id); // Rol bilgisini çek

      if (role != null) {
        userRole = role; // Rolü ata

        // Giriş başarılı
        print('Giriş başarılı: ${user.username}');
        print('Kullanıcının rolü: ${userRole.role_name}'); // Rol bilgisi
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Homepage(username: username, userRole: userRole,)), // Rolü Homepage'e geçir
        );
      } else {
        passwordController.clear(); // Şifre alanını temizle
        _showErrorDialog(context); // Rol bulunamadıysa hata göster
      }
    } else {
      passwordController.clear(); // Şifre alanını temizle
      _showErrorDialog(context);
    }
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: smallWidgetColor,
          title: Text('Hatalı Giriş'),
          content: Text('Kullanıcı adı veya şifre hatalı. Lütfen tekrar deneyin.'),
          actions: <Widget>[
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop(); // Pop-up'ı kapat
              },
            ),
          ],
        );
      },
    );
  }

  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: mainColor,
          title: Text('Çıkış Yap'),
          content: Text('Çıkış yapmak istediğinizden emin misiniz?'),
          actions: <Widget>[
            TextButton(
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Çıkış Yap'),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}