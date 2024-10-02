import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastrobluecheckapp/data/repo/userdao_repository.dart';

import '../../data/entity/user.dart';

class UserListCubit extends Cubit <List<User>>{
  UserListCubit():super(<User>[]);
  var URepo = UserDaoRepository();

  Future<void> loadUsers() async {
    var list = await URepo.loadUsers();
    emit(list);
  }

  Future<void> search(String word) async {
    var list = await URepo.search(word);
    emit(list);
  }

  Future<void> delete(int id) async {
    await URepo.delete(id);
    await loadUsers();
  }
}