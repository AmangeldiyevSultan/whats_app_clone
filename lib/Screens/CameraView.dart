import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whats_app_clone/utils/dimensions.dart';

class CameraViewPage extends StatelessWidget {
  const CameraViewPage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.crop_rotate)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.emoji_emotions_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.title)),
          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
        ],
      ),
      body: Container(
        width: Dimensions.screenWidth,
        height: Dimensions.screenHeight,
        child: Stack(
          children: [
            Container(
              width: Dimensions.screenWidth,
              height: Dimensions.screenHeight - Dimensions.height30 * 5,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: Dimensions.screenWidth,
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height10 / 2,
                    horizontal: Dimensions.width45 / 5),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: 6,
                  minLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.font16
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.add_photo_alternate, color: Colors.white, size: Dimensions.iconSize32 ,),
                      border: InputBorder.none,
                      hintText: "Add Caption",
                  suffixIcon: CircleAvatar(
                    radius: Dimensions.radius30 - Dimensions.radius30/10,
                    backgroundColor: Colors.tealAccent[700],
                    child: Icon(Icons.check,color: Colors.white, size: Dimensions.iconSize24,),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: Dimensions.font16
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
