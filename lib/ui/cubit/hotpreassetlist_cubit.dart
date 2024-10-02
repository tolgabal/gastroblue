import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastrobluecheckapp/data/entity/hotpresentationasset.dart';
import 'package:gastrobluecheckapp/data/repo/assetlistsdao_repository.dart';

class HotPreAssetListCubit extends Cubit<List<HotPresentationAsset>>{

HotPreAssetListCubit():super(<HotPresentationAsset>[]);

var ALRepo = AssetListDaoRepository();

  Future<void> loadAssets() async {
    var list = await ALRepo.loadAssets();
    emit(list);
  }

Future<void> search(String word) async {
  var list = await ALRepo.search(word);
  emit(list);
}

Future<void> delete(int id) async {
  await ALRepo.delete(id);
  await loadAssets();
}
}