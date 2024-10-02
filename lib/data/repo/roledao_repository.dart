import 'package:gastrobluecheckapp/data/entity/role.dart';
import 'package:gastrobluecheckapp/sqlite/db_helper.dart';

class RoleDaoRepository {
  Future<void> submit(String role_name, bool hotpre, bool coldpre, bool disinf, bool soak, bool candr, bool receiving, bool disinf_list, bool candr_list, bool hotpre_list, bool coldpre_list, bool receiving_firms, bool personnel, bool buffedtimes, bool roleconfig, bool reports, bool devices, bool updateuser) async {
    var db = await DbHelper.veritabaniErisim();
    var newRole = Map<String,dynamic>();
    newRole["role_name"] = role_name;
    hotpre ? newRole["hotpre"] = 1 : newRole["hotpre"] = 0;
    coldpre ? newRole["coldpre"] = 1 : newRole["coldpre"] = 0;
    disinf ? newRole["disinf"] = 1 : newRole["disinf"] = 0;
    soak ? newRole["soak"] = 1 : newRole["soak"] = 0;
    candr ? newRole["candr"] = 1 : newRole["candr"] = 0;
    receiving ? newRole["receiving"] = 1 : newRole["receiving"] = 0;
    disinf_list ? newRole["disinf_list"] = 1 : newRole["disinf_list"] = 0;
    candr_list ? newRole["candr_list"] = 1 : newRole["candr_list"] = 0;
    hotpre_list ? newRole["hotpre_list"] = 1 : newRole["hotpre_list"] = 0;
    coldpre_list ? newRole["coldpre_list"] = 1 : newRole["coldpre_list"] = 0;
    receiving_firms ? newRole["receiving_firms"] = 1 : newRole["receiving_firms"] = 0;
    personnel ? newRole["personnel"] = 1 : newRole["personnel"] = 0;
    buffedtimes ? newRole["buffedtimes"] = 1 : newRole["buffedtimes"] = 0;
    roleconfig ? newRole["roleconfig"] = 1 : newRole["roleconfig"] = 0;
    reports ? newRole["reports"] = 1 : newRole["reports"] = 0;
    devices ? newRole["devices"] = 1 : newRole["devices"] = 0;
    updateuser ? newRole["updateuser"] = 1 : newRole["updateuser"] = 0;
    await db.insert("role", newRole);
  }

  Future<void> update(int id, String role_name, bool hotpre, bool coldpre, bool disinf, bool soak, bool candr, bool receiving, bool disinf_list, bool candr_list, bool hotpre_list, bool coldpre_list, bool receiving_firms, bool personnel, bool buffedtimes, bool roleconfig, bool reports, bool devices, bool updateuser) async {
    var db = await DbHelper.veritabaniErisim();
    var updRole = Map<String, dynamic>();
    updRole["role_name"] = role_name;
    hotpre ? updRole["hotpre"] = 1 : updRole["hotpre"] = 0;
    coldpre ? updRole["coldpre"] = 1 : updRole["coldpre"] = 0;
    disinf ? updRole["disinf"] = 1 : updRole["disinf"] = 0;
    soak ? updRole["soak"] = 1 : updRole["soak"] = 0;
    candr ? updRole["candr"] = 1 : updRole["candr"] = 0;
    receiving ? updRole["receiving"] = 1 : updRole["receiving"] = 0;
    disinf_list ? updRole["disinf_list"] = 1 : updRole["disinf_list"] = 0;
    candr_list ? updRole["candr_list"] = 1 : updRole["candr_list"] = 0;
    hotpre_list ? updRole["hotpre_list"] = 1 : updRole["hotpre_list"] = 0;
    coldpre_list ? updRole["coldpre_list"] = 1 : updRole["coldpre_list"] = 0;
    receiving_firms
        ? updRole["receiving_firms"] = 1
        : updRole["receiving_firms"] = 0;
    personnel ? updRole["personnel"] = 1 : updRole["personnel"] = 0;
    buffedtimes ? updRole["buffedtimes"] = 1 : updRole["buffedtimes"] = 0;
    roleconfig ? updRole["roleconfig"] = 1 : updRole["roleconfig"] = 0;
    reports ? updRole["reports"] = 1 : updRole["reports"] = 0;
    devices ? updRole["devices"] = 1 : updRole["devices"] = 0;
    updateuser ? updRole["updateuser"] = 1 : updRole["updateuser"] = 0;
    await db.update("role", updRole, where: "id = ?", whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    var db = await DbHelper.veritabaniErisim();
    await db.delete("role", where: "id = ?", whereArgs: [id]);
  }

  Future<List<Role>> loadRoles() async {
    var db = await DbHelper.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM role");

    return List.generate(maps.length, (index) {
      var raw = maps[index];
      return Role(raw["id"],raw["role_name"],raw["hotpre"], raw["coldpre"], raw["disinf"], raw["soak"], raw["candr"], raw["receiving"], raw["disinf_list"], raw["candr_list"], raw["hotpre_list"], raw["coldpre_list"], raw["receiving_firms"], raw["personnel"], raw["buffedtimes"], raw["roleconfig"], raw["reports"], raw["devices"], raw["updateuser"]);
    });
  }

  Future<List<Role>> search(String word) async {
    var db = await DbHelper.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM role WHERE role_name like '%$word%'");

    return List.generate(maps.length, (index) {
      var raw = maps[index];
      return Role(raw["id"],raw["role_name"],raw["hotpre"], raw["coldpre"], raw["disinf"], raw["soak"], raw["candr"], raw["receiving"], raw["disinf_list"], raw["candr_list"], raw["hotpre_list"], raw["coldpre_list"], raw["receiving_firms"], raw["personnel"], raw["buffedtimes"], raw["roleconfig"], raw["reports"], raw["devices"], raw["updateuser"]);
    });
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