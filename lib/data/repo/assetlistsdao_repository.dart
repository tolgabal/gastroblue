import 'package:gastrobluecheckapp/data/entity/hotpresentationasset.dart';
import 'package:gastrobluecheckapp/sqlite/db_helper.dart';

class AssetListDaoRepository {
  Future<void> submit(String asset_name, bool reuse_isactive) async {
    var db = await DbHelper.veritabaniErisim();
    var newUser = Map<String,dynamic>();
    newUser["asset_name"] = asset_name;
    int reuse = 1;
    if(reuse_isactive == false) reuse = 0;
    newUser["reuse_isactive"] = reuse;
    await db.insert("hotpreasset", newUser);
  }

  Future<void> update(int asset_id, String asset_name, bool reuse_isactive) async {
    var db = await DbHelper.veritabaniErisim();
    var updUser = Map<String,dynamic>();
    updUser["asset_name"] = asset_name;
    int reuse = 1;
    if(reuse_isactive == false) reuse = 0;
    updUser["reuse_isactive"] = reuse;
    await db.update("hotpreasset", updUser, where: "id = ?", whereArgs: [asset_id]);
  }

  Future<void> delete(int id) async {
    var db = await DbHelper.veritabaniErisim();
    await db.delete("hotpreasset", where: "id = ?", whereArgs: [id]);
  }

  Future<List<HotPresentationAsset>> loadAssets() async {
    var db = await DbHelper.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM hotpreasset");

    return List.generate(maps.length, (index) {
      var raw = maps[index];
      bool reuse = true;
      if(raw["reuse_isactive"] == 0) reuse = false;
      return HotPresentationAsset(id: raw["id"], asset_name: raw["asset_name"], reuse_isactive: reuse);
    });
  }

  Future<List<HotPresentationAsset>> search(String word) async {
    var db = await DbHelper.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM hotpreasset WHERE asset_name like '%$word%'");

    return List.generate(maps.length, (index) {
      var raw = maps[index];
      bool reuse = true;
      if(raw["reuse_isactive"] == 0) reuse = false;
      return HotPresentationAsset(id: raw["id"], asset_name: raw["asset_name"], reuse_isactive: reuse);
    });
  }
}