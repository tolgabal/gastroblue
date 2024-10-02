import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastrobluecheckapp/data/repo/roledao_repository.dart';

import '../../data/entity/role.dart';
import '../../sqlite/db_helper.dart';

class RoleConfigListCubit extends Cubit <List<Role>>{
  RoleConfigListCubit():super(<Role>[]);
  var RRepo = RoleDaoRepository();

  Future<void> loadRoles() async {
    var list = await RRepo.loadRoles();
    emit(list);
  }

  Future<void> search(String word) async {
    var list = await RRepo.search(word);
    emit(list);
  }

  Future<void> delete(int id) async {
    await RRepo.delete(id);
    await loadRoles();
  }

  Future<Role?> loadRoleById(int id) async {
    var db = await DbHelper.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM role WHERE id = ?", [id]);

    // Eğer sonuç yoksa null döner
    if (maps.isEmpty) {
      return null;
    }

    // İlk sonucu döndür
    var raw = maps.first;
    return Role(
      raw["id"],
      raw["role_name"],
      raw["hotpre"],
      raw["coldpre"],
      raw["disinf"],
      raw["soak"],
      raw["candr"],
      raw["receiving"],
      raw["disinf_list"],
      raw["candr_list"],
      raw["hotpre_list"],
      raw["coldpre_list"],
      raw["receiving_firms"],
      raw["personnel"],
      raw["buffedtimes"],
      raw["roleconfig"],
      raw["reports"],
      raw["devices"],
      raw["updateuser"],
    );
  }

}