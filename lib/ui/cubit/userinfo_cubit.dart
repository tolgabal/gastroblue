import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastrobluecheckapp/data/repo/userdao_repository.dart';

class UserInfoCubit extends Cubit{
  UserInfoCubit():super(0);

  var URepo = UserDaoRepository();

  Future<void> update(int id, int role_id, String username, String password, String name, String hotel) async {
    await URepo.update(id, role_id, username, password, name, hotel);
  }
}