import 'package:gastrobluecheckapp/data/entity/user.dart';
import 'package:gastrobluecheckapp/sqlite/db_helper.dart';

class UserDaoRepository {
  Future<void> submit(int role_id, String username, String password, String name, String hotel) async {
    var db = await DbHelper.veritabaniErisim();
    var newUser = Map<String,dynamic>();
    newUser["role_id"] = role_id;
    newUser["username"] = username;
    newUser["password"] = password;
    newUser["name"] = name;
    newUser["hotel"] = hotel;
    await db.insert("user", newUser);
  }

  Future<void> update(int id, int role_id, String username, String password, String name, String hotel) async {
    var db = await DbHelper.veritabaniErisim();
    var updUser = Map<String, dynamic>();
    updUser["role_id"] = role_id;
    updUser["username"] = username;
    updUser["password"] = password;
    updUser["name"] = name;
    updUser["hotel"] = hotel;
    await db.update("user", updUser, where: "id = ?", whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    var db = await DbHelper.veritabaniErisim();
    await db.delete("user", where: "id = ?", whereArgs: [id]);
  }

  Future<List<User>> loadUsers() async {
    var db = await DbHelper.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM user");

    return List.generate(maps.length, (index) {
      var raw = maps[index];
      return User(raw["id"],raw["role_id"],raw["username"], raw["password"], raw["name"], raw["hotel"]);
    });
  }

  Future<List<User>> search(String word) async {
    var db = await DbHelper.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM user WHERE role_name like '%$word%'");

    return List.generate(maps.length, (index) {
      var raw = maps[index];
      return User(raw["id"],raw["role_id"],raw["username"], raw["password"], raw["name"], raw["hotel"]);
    });
  }
}