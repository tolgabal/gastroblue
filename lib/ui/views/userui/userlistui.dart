import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastrobluecheckapp/main.dart';
import 'package:gastrobluecheckapp/ui/cubit/userlist_cubit.dart';
import 'package:gastrobluecheckapp/ui/views/userui/userinfoui.dart';
import 'package:gastrobluecheckapp/ui/views/userui/usersubmitui.dart';

import '../../../color.dart';
import '../../../data/entity/user.dart';

class UserListUI extends StatefulWidget {
  const UserListUI({super.key});

  @override
  State<UserListUI> createState() => _UserListUIState();
}

class _UserListUIState extends State<UserListUI> {
  bool searchIsActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserListCubit>().loadUsers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: searchIsActive
            ? TextField(
          decoration: InputDecoration(hintText: "Search User"),
          onChanged: (searching) {
            context.read<UserListCubit>().search(searching);
          },
        )
            : const Text("Personnel List"),
        actions: [
          searchIsActive
              ? IconButton(
            onPressed: () {
              setState(() {
                searchIsActive = false;
              });
              context.read<UserListCubit>().loadUsers();
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
      body: BlocBuilder<UserListCubit, List<User>>(
        builder: (context, userList) {
          if(userList.isNotEmpty) {
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                var user = userList[index];
                return Dismissible(
                  key: Key(user.id.toString()),
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
                              "Do you want to delete ${user.username} role?"
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
                    context.read<UserListCubit>().delete(user.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${user.username} deleted",style: TextStyle(color: Colors.black),),
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
                      title: Text(user.username),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserInfoUI(user)
                          ),
                        ).then((value) {
                          context.read<UserListCubit>().loadUsers();
                        });
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No Users available"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: bigWidgetColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UserSubmitUI()
              ))
              .then((value) {
            context.read<UserListCubit>().loadUsers();
          });
        },
        child: const Icon(Icons.add, color: Colors.white),),
    );
  }
}

