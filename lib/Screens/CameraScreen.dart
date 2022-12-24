import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:whats_app_clone/CustomUI/CustomText.dart';
import 'package:whats_app_clone/Screens/CameraView.dart';
import 'package:whats_app_clone/Screens/VideoView.dart';

import '../utils/dimensions.dart';

List<CameraDescription>? cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late VideoPlayerController _videoPlayerController;
  late Future<void> cameraValue;
  bool isRecording = false;
  bool flashLight = false;
  bool camerasPosition = true;
  double transform = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: CameraPreview(_cameraController));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),

          /// CAMERA_BUTTONS
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              color: Colors.black,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              flashLight = !flashLight;
                            });
                            flashLight ? _cameraController.setFlashMode(
                                FlashMode.torch) : _cameraController
                                .setFlashMode(FlashMode.off);
                          },
                          icon: Icon(
                            flashLight ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          )),
                      GestureDetector(

                        /// TakeVideo
                        onLongPress: () async {
                          takeVideo(context);
                        },

                        /// StopVideo
                        onLongPressUp: () async {
                          stopVideo(context);
                        },

                        /// TakePhoto
                        onTap: () {
                          if (!isRecording)
                            takePhoto(context);
                        },
                        child: isRecording
                            ? Icon(
                          Icons.radio_button_on,
                          color: Colors.red,
                          size: 80,
                        )
                            : Icon(
                          Icons.panorama_fish_eye,
                          color: Colors.white,
                          size: Dimensions.iconSize15 * 4 + ((Dimensions
                              .iconSize15 / 3) * 2),
                        ),
                      ),
                      IconButton(
                          onPressed: () async{
                            setState(() {
                              camerasPosition = !camerasPosition;
                              transform = transform + pi;
                            });
                            int camerasPos = camerasPosition ? 0 : 1;
                            _cameraController = CameraController(cameras![camerasPos], ResolutionPreset.high);
                            cameraValue = _cameraController.initialize();
                          },
                          icon: Transform.rotate(
                            angle: transform,
                            child: Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                              size: 28,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  CustomText(
                    text: "Hold for Video, tap for photo",
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    try {
      // final tmpDirectory = await getTemporaryDirectory();
      // final filePath = '${DateTime.now()}.png';
      // final path = join(tmpDirectory.path, filePath);
      // image.saveTo(path);
      XFile image = await _cameraController.takePicture();


      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (builder) =>
                  CameraViewPage(
                    path: image.path,
                  )));
    } catch (e) {
      print(e);
    }
  }

  void takeVideo(BuildContext context) async {
    try {
      // final tmpDirectory = await getTemporaryDirectory();
      // final filePath = '${DateTime.now()}.mp4';
      // final path = join(tmpDirectory.path, filePath);
      await _cameraController.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> stopVideo(BuildContext context) async {
    XFile videoFile = await _cameraController.stopVideoRecording();
    setState(() {
      isRecording = false;
    });

    Navigator.push(context, MaterialPageRoute(
        builder: (builder) => VideoViewPage(path: videoFile.path)));
  }
}
