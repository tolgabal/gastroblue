import 'package:flutter/material.dart';
import 'package:gastrobluecheckapp/color.dart';
import 'package:gastrobluecheckapp/ui/views/roleconfigui/roleconfiglistui.dart';

import '../views/hotpresentationui/hotpreassetlistui.dart';
import '../views/userui/userlistui.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double height;
  final IconData icon;
  final int id;

  CustomButton({
    required this.text,
    required this.height,
    required this.icon,
    required this.id
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if( id == 1 ){
          print("$text butonuna basıldı! $id");
        }else if (id == 2){
          print("$text butonuna basıldı! $id");
        }else if (id == 3){
          print("$text butonuna basıldı! $id");
        }else if (id == 4){
          print("$text butonuna basıldı! $id");
        }else if (id == 5){
          print("$text butonuna basıldı! $id");
        }else if (id == 6){
          print("$text butonuna basıldı! $id");
        }else if (id == 7){
          print("$text butonuna basıldı! $id");
        }else if (id == 8){
          print("$text butonuna basıldı! $id");
        }else if (id == 9){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HotPreAssetListUI()));
        }else if (id == 10){
          print("$text butonuna basıldı! $id");
        }else if (id == 11){
          print("$text butonuna basıldı! $id");
        }else if (id == 12){
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserListUI()));
        }else if (id == 13){
          print("$text butonuna basıldı! $id");
        }else if (id == 14){
          Navigator.push(context, MaterialPageRoute(builder: (context) => RoleConfigListUI()));
        }else if (id == 15){
          print("$text butonuna basıldı! $id");
        }


      },
      child: Card(
        color: smallWidgetColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Yuvarlak köşeler
        ),
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 40,color: mainColor,), // Sol üst köşedeki ikon
                Spacer(),
                Text(
                  text.toUpperCase(),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.arrow_forward,color: mainColor,), // Ok simgesi
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}