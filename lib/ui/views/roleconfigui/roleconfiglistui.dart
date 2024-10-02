import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastrobluecheckapp/color.dart';
import 'package:gastrobluecheckapp/data/entity/role.dart';
import 'package:gastrobluecheckapp/main.dart';
import 'package:gastrobluecheckapp/ui/cubit/roleconfiglist_cubit.dart';
import 'package:gastrobluecheckapp/ui/views/roleconfigui/roleconfiginfoui.dart';
import 'package:gastrobluecheckapp/ui/views/roleconfigui/roleconfigsubmitui.dart';

class RoleConfigListUI extends StatefulWidget {
  const RoleConfigListUI({super.key});

  @override
  State<RoleConfigListUI> createState() => _RoleConfigListUIState();
}

class _RoleConfigListUIState extends State<RoleConfigListUI> {
  bool searchIsActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RoleConfigListCubit>().loadRoles();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: searchIsActive
          ? TextField(
          decoration: InputDecoration(hintText: "Search Role"),
          onChanged: (searching) {
            context.read<RoleConfigListCubit>().search(searching);
          },
        )
            : const Text("Role List"),
        actions: [
          searchIsActive
              ? IconButton(
              onPressed: () {
                setState(() {
                  searchIsActive = false;
                });
                context.read<RoleConfigListCubit>().loadRoles();
              },
              icon: const Icon(Icons.clear),
          )
              : IconButton(
            onPressed: () {
              setState(() {
                searchIsActive = true;
              });
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: BlocBuilder<RoleConfigListCubit, List<Role>>(
        builder: (context, roleList) {
          if(roleList.isNotEmpty) {
            return ListView.builder(
              itemCount: roleList.length,
              itemBuilder: (context, index) {
                var role = roleList[index];
                return Dismissible(
                  key: Key(role.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "Do you want to delete ${role.role_name} role?"
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("No"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("Yes"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                    context.read<RoleConfigListCubit>().delete(role.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${role.role_name} deleted",style: TextStyle(color: Colors.black),),
                        backgroundColor: smallWidgetColor,
                      ),
                    );
                  },
                  child: Card(
                    color: smallWidgetColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      title: Text(role.role_name),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RoleConfigInfoUI(role)
                          ),
                        ).then((value) {
                          context.read<RoleConfigListCubit>().loadRoles();
                        });
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No Roles available"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: bigWidgetColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RoleConfigSubmitUI()
              ))
              .then((value) {
                context.read<RoleConfigListCubit>().loadRoles();
          });
        },
      child: const Icon(Icons.add, color: Colors.white),),
    );
  }
}

