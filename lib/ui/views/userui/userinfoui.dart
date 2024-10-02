import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastrobluecheckapp/data/entity/user.dart';
import 'package:gastrobluecheckapp/data/entity/role.dart'; // Rol modelini içe aktar
import 'package:gastrobluecheckapp/ui/cubit/userinfo_cubit.dart'; // Kullanıcı güncelleme işlemi için Cubit'i buradan içe aktar
import 'package:gastrobluecheckapp/ui/cubit/roleconfiglist_cubit.dart'; // Role Cubit'i içe aktar
import 'package:gastrobluecheckapp/ui/views/userui/userlistui.dart'; // Güncelleme sonrası yönlendirilecek sayfa

class UserInfoUI extends StatefulWidget {
  final User user;

  UserInfoUI(this.user);

  @override
  State<UserInfoUI> createState() => _UserInfoUIState();
}

class _UserInfoUIState extends State<UserInfoUI> {
  var tfUsername = TextEditingController();
  var tfPassword = TextEditingController();
  var tfName = TextEditingController();
  var tfHotel = TextEditingController();

  // Seçilen role id'yi burada saklayacağız
  int? selectedRoleId;

  @override
  void initState() {
    super.initState();
    // Kullanıcı bilgilerinin mevcut değerlerini TextField'lara dolduruyoruz
    var user = widget.user;
    tfUsername.text = user.username;
    tfPassword.text = user.password;
    tfName.text = user.name;
    tfHotel.text = user.hotel;

    // Mevcut role_id'yi sakla
    selectedRoleId = user.role_id;

    // Roller yüklensin
    context.read<RoleConfigListCubit>().loadRoles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Information Page")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Kullanıcı adı alanı
              TextField(
                controller: tfUsername,
                decoration: const InputDecoration(hintText: "Username"),
              ),
              // Şifre alanı
              TextField(
                controller: tfPassword,
                decoration: const InputDecoration(hintText: "Password"),
                obscureText: true,
              ),
              // İsim alanı
              TextField(
                controller: tfName,
                decoration: const InputDecoration(hintText: "Name"),
              ),
              // Otel alanı
              TextField(
                controller: tfHotel,
                decoration: const InputDecoration(hintText: "Hotel"),
              ),

              // Rol seçim dropdown'u
              BlocBuilder<RoleConfigListCubit, List<Role>>(
                builder: (context, roleList) {
                  if (roleList.isEmpty) {
                    return const Center(child: Text("No roles available"));
                  }

                  return DropdownButtonFormField<int>(
                    hint: const Text("Select Role"),
                    value: selectedRoleId, // Mevcut role id'yi göstermek için
                    items: roleList.map((role) {
                      return DropdownMenuItem<int>(
                        value: role.id,
                        child: Text(role.role_name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRoleId = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  );
                },
              ),

              // Güncelle butonu
              ElevatedButton(
                onPressed: () {
                  // Eğer rol seçilmediyse hata verdir
                  if (selectedRoleId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select a role"),
                      ),
                    );
                    return;
                  }

                  // Bloc yardımıyla kullanıcı güncellemesi yapılıyor
                  context.read<UserInfoCubit>().update(
                    widget.user.id,
                    selectedRoleId!, // Seçilen role_id'yi gönderiyoruz
                    tfUsername.text,
                    tfPassword.text,
                    tfName.text,
                    tfHotel.text,
                  );

                  // Güncelleme sonrası kullanıcı listesine geri dönülüyor
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UserListUI()));
                },
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}