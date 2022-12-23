import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whats_app_clone/utils/dimensions.dart';

class VideoViewPage extends StatefulWidget {
  const VideoViewPage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  State<VideoViewPage> createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  late VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          print("STARTED");
        });
      });
  }

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
              child: _videoPlayerController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    )
                  : Container(),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: Dimensions.screenWidth,
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height10 / 2,
                    horizontal: Dimensions.widtht45 / 5),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: 6,
                  minLines: 1,
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimensions.font16),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.add_photo_alternate,
                        color: Colors.white,
                        size: Dimensions.iconSize32,
                      ),
                      border: InputBorder.none,
                      hintText: "Add Caption",
                      suffixIcon: CircleAvatar(
                        radius: Dimensions.radius30 - Dimensions.radius30 / 10,
                        backgroundColor: Colors.tealAccent[700],
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: Dimensions.iconSize24,
                        ),
                      ),
                      hintStyle: TextStyle(
                          color: Colors.white, fontSize: Dimensions.font16)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _videoPlayerController.value.isPlaying
                        ? _videoPlayerController.pause()
                        : _videoPlayerController.play();
                  });
                },
                child: CircleAvatar(
                    radius: Dimensions.radius30 + Dimensions.radius30 / 10,
                    backgroundColor: Colors.black38,
                    child: Icon(
                      _videoPlayerController.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: Dimensions.iconSize15 * 4 -
                          ((Dimensions.iconSize15 / 5) * 2),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
