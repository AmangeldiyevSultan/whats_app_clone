import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
  late Future<void> cameraValue;
  bool isRecording = false;
  String videoPath ="";

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
                      child: CameraPreview(_cameraController));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          )),
                      GestureDetector(
                        onLongPress: () async {
                          takeVideo(context);
                        },
                        onLongPressUp: () async{
                         final file =  await _cameraController.stopVideoRecording();
                         var filePath = file.path;
                         print("DIFFERENCE____________");
                         print(filePath);
                         print(videoPath);
                          setState(() {
                            isRecording = false;
                          });

                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>VideoViewPage(path: filePath)));
                        },
                        onTap: () {
                          if(!isRecording)
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
                                size: Dimensions.iconSize15*4 + ((Dimensions.iconSize15/3)*2),
                              ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 28,
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
      final tmpDirectory = await getTemporaryDirectory();
      final filePath = '${DateTime.now()}.png';
      final path = join(tmpDirectory.path, filePath);

      final image = await _cameraController.takePicture();
      final imagePath = image.saveTo(path);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (builder) => CameraViewPage(
                    path: path,
                  )));
    } catch (e) {
      print(e);
    }
  }

  void takeVideo(BuildContext context) async {
    try {
      final tmpDirectory = await getTemporaryDirectory();
      final filePath = '${DateTime.now()}.mp4';
      final path = join(tmpDirectory.path, filePath);
      await _cameraController.startVideoRecording();
      setState(() {
        isRecording = true;
        videoPath = path;
      });
    } catch (e) {
      print(e);
    }
  }
}
