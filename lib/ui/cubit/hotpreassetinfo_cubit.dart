import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastrobluecheckapp/data/repo/assetlistsdao_repository.dart';

class HotPreAssetInfoCubit extends Cubit{
  HotPreAssetInfoCubit():super(0);

  var ALRepo = AssetListDaoRepository();

  Future<void> update(int asset_id, String asset_name, bool reuse_isactive) async {
    await ALRepo.update(asset_id, asset_name, reuse_isactive);
  }
}