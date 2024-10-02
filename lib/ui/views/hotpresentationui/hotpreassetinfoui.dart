import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastrobluecheckapp/data/entity/hotpresentationasset.dart';
import 'package:gastrobluecheckapp/main.dart';
import 'package:gastrobluecheckapp/ui/cubit/hotpreassetinfo_cubit.dart';
import 'package:gastrobluecheckapp/ui/views/hotpresentationui/hotpreassetlistui.dart';

class hotPreAssetInfoUI extends StatefulWidget {
  HotPresentationAsset asset;
  hotPreAssetInfoUI(this.asset);

  @override
  State<hotPreAssetInfoUI> createState() => _hotPreAssetInfoUIState();
}

class _hotPreAssetInfoUIState extends State<hotPreAssetInfoUI> {
  var tfAssetName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    var asset = widget.asset;
    tfAssetName.text = asset.asset_name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Information Page"),),
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfAssetName, decoration: const InputDecoration(hintText: "Asset Name"),),

              ElevatedButton(onPressed: (){
                context.read<HotPreAssetInfoCubit>().update(widget.asset.id, tfAssetName.text, true);
                Navigator.push(context, MaterialPageRoute(builder: (context) => HotPreAssetListUI()));
              }, child: Text("Update"))
            ],
          ),
        ),
      ),
    );
  }
}
