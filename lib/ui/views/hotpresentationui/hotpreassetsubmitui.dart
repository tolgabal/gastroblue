import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastrobluecheckapp/main.dart';
import 'package:gastrobluecheckapp/ui/cubit/hotpreassetsubmit_cubit.dart';
import 'package:gastrobluecheckapp/ui/views/hotpresentationui/hotpreassetlistui.dart';

class HotPreAssetSubmitUI extends StatefulWidget {
  const HotPreAssetSubmitUI({super.key});

  @override
  State<HotPreAssetSubmitUI> createState() => _HotPreAssetSubmitUIState();
}

class _HotPreAssetSubmitUIState extends State<HotPreAssetSubmitUI> {
  var tfAssetName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Asset Submit"),),
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfAssetName, decoration: const InputDecoration(hintText: "Asset Name"),),

              ElevatedButton(onPressed: (){
                context.read<HotPreAssetSubmitCubit>().submit(tfAssetName.text,true);
                Navigator.push(context, MaterialPageRoute(builder: (context) => HotPreAssetListUI()));
              }, child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
