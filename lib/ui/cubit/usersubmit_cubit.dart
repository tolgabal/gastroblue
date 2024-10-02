import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastrobluecheckapp/data/repo/userdao_repository.dart';

class UserSubmitCubit extends Cubit{
  UserSubmitCubit():super(0);

  var URepo = UserDaoRepository();

  Future<void> submit(int role_id, String username, String password, String name, String hotel) async {
    URepo.submit(role_id, username, password, name, hotel);
  }
}