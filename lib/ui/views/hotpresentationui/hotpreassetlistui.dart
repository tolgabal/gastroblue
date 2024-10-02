import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastrobluecheckapp/color.dart';
import 'package:gastrobluecheckapp/data/entity/hotpresentationasset.dart';
import 'package:gastrobluecheckapp/ui/cubit/hotpreassetlist_cubit.dart';
import 'package:gastrobluecheckapp/ui/views/hotpresentationui/hotpreassetinfoui.dart';
import 'package:gastrobluecheckapp/ui/views/hotpresentationui/hotpreassetsubmitui.dart';

class HotPreAssetListUI extends StatefulWidget {
  const HotPreAssetListUI({super.key});

  @override
  State<HotPreAssetListUI> createState() => _HotPreAssetListUIState();
}

class _HotPreAssetListUIState extends State<HotPreAssetListUI> {
  bool searchIsActive = false;

  @override
  void initState() {
    super.initState();
    context.read<HotPreAssetListCubit>().loadAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: searchIsActive
            ? TextField(
          decoration: InputDecoration(hintText: "Search Asset"),
          onChanged: (searching) {
            context.read<HotPreAssetListCubit>().search(searching);
          },
        )
            : const Text("Hot Presentation Asset List"),
        actions: [
          searchIsActive
              ? IconButton(
              onPressed: () {
                setState(() {
                  searchIsActive = false;
                });
                context.read<HotPreAssetListCubit>().loadAssets();
              },
              icon: const Icon(Icons.clear))
              : IconButton(
              onPressed: () {
                setState(() {
                  searchIsActive = true;
                });
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<HotPreAssetListCubit, List<HotPresentationAsset>>(
        builder: (context, assetList) {
          if (assetList.isNotEmpty) {
            return ListView.builder(
              itemCount: assetList.length,
              itemBuilder: (context, indeks) {
                var asset = assetList[indeks];
                return Dismissible(
                  key: Key(asset.id.toString()),
                  direction: DismissDirection.endToStart, // Sağa kaydırma yönü
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                              "Do you want to delete ${asset.asset_name}?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("No"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("Yes"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                    // Varlığı silme işlemi
                    context.read<HotPreAssetListCubit>().delete(asset.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${asset.asset_name} deleted",style: TextStyle(color: Colors.black),),
                        backgroundColor: smallWidgetColor,),
                    );
                  },
                  child: Card(
                    color: smallWidgetColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      title: Text(asset.asset_name),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  hotPreAssetInfoUI(asset)),
                        ).then((value) {
                          context.read<HotPreAssetListCubit>().loadAssets();
                        });
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No assets available."));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: bigWidgetColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HotPreAssetSubmitUI()))
              .then((value) {
            context.read<HotPreAssetListCubit>().loadAssets();
          });
        },
        child: const Icon(Icons.add,color: Colors.white),
      ),
    );
  }
}