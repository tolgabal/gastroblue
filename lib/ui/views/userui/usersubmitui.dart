import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastrobluecheckapp/ui/cubit/usersubmit_cubit.dart';
import 'package:gastrobluecheckapp/ui/cubit/roleconfiglist_cubit.dart';
import 'package:gastrobluecheckapp/ui/views/userui/userlistui.dart';
import 'package:gastrobluecheckapp/data/entity/role.dart';

class UserSubmitUI extends StatefulWidget {
  const UserSubmitUI({super.key});

  @override
  State<UserSubmitUI> createState() => _UserSubmitUIState();
}

class _UserSubmitUIState extends State<UserSubmitUI> {
  var tfUsername = TextEditingController();
  var tfPassword = TextEditingController();
  var tfName = TextEditingController();
  var tfHotel = TextEditingController();

  // Seçilen role id'yi burada saklayacağız
  int? selectedRoleId;

  @override
  void initState() {
    super.initState();
    // Role listesini sayfa yüklendiğinde çek
    context.read<RoleConfigListCubit>().loadRoles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Submit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Username input field
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  controller: tfUsername,
                  decoration: const InputDecoration(
                    hintText: "Username",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // Password input field
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  controller: tfPassword,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),

              // Name input field
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  controller: tfName,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // Hotel input field
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  controller: tfHotel,
                  decoration: const InputDecoration(
                    hintText: "Hotel",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // Role selection dropdown
              BlocBuilder<RoleConfigListCubit, List<Role>>(
                builder: (context, roleList) {
                  if (roleList.isEmpty) {
                    return const Center(child: Text("No roles available"));
                  }

                  return DropdownButtonFormField<int>(
                    hint: const Text("Select Role"),
                    value: selectedRoleId,
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

              const SizedBox(height: 20), // Adding some space before the submit button
              ElevatedButton(
                onPressed: () {
                  if (selectedRoleId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select a role"),
                      ),
                    );
                    return;
                  }

                  // Submit user data using the Cubit
                  context.read<UserSubmitCubit>().submit(
                    selectedRoleId!, // Seçilen role_id'yi gönderiyoruz
                    tfUsername.text,
                    tfPassword.text,
                    tfName.text,
                    tfHotel.text,
                  );

                  // Navigate back to the User List UI
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserListUI()),
                  );
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}