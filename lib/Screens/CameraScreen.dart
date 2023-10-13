import 'dart:math';
import 'package:cd_whatsapp_clone/Screens/CameraView.dart';
import 'package:cd_whatsapp_clone/Screens/VideoView.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key key, this.onImageSend}) : super(key: key);
  final Function onImageSend;

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _cameraController;
  Future<void> cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool isCameraFront = true;
  double transform = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.max);
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
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: CameraPreview(_cameraController),
                      );
                  }else{
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                },
              ),
            Positioned(
              bottom: 0.0,
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.only(top: 5, bottom: 5),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            icon: Icon(
                                flash ? Icons.flash_on : Icons.flash_off,
                                color: Colors.white,
                                size: 28,
                            ),
                          onPressed: (){
                              setState(() {
                                flash = !flash;
                              });
                              flash ? _cameraController.setFlashMode(FlashMode.torch) : _cameraController.setFlashMode(FlashMode.off);
                          },),
                        GestureDetector(
                          onLongPress: () async{
                              await _cameraController.startVideoRecording();
                              setState(() {
                                isRecording = true;
                              });
                          },
                          onLongPressUp: ()async{
                              XFile videoPath = await _cameraController.stopVideoRecording();
                              setState(() {
                                isRecording = false;
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (builder)=>VideoViewPage(path: videoPath.path)));
                          },
                          onTap: (){
                            if(!isRecording)
                            takePhoto(context);
                          },
                          child: isRecording
                                ? Icon(
                              Icons.radio_button_on,
                              color: Colors.red,
                              size: 80,
                            ) : Icon(
                              Icons.panorama_fish_eye,
                              color: Colors.white,
                              size: 70
                          ),
                        ),
                        IconButton(
                          icon: Transform.rotate(
                            angle: transform,
                            child: Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                              size: 28
                          ),),
                          onPressed: (){
                            setState(() {
                              isCameraFront = !isCameraFront;
                              transform = transform + pi;
                            });
                            int cameraPos = isCameraFront ? 0 : 1;
                            _cameraController = CameraController(cameras[cameraPos], ResolutionPreset.max);
                            cameraValue = _cameraController.initialize();
                          },),
                      ],
                    ),
                    SizedBox(height: 4,),
                    Text("Hold for video, tap for photo", style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,)
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
      //final path = join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
      XFile file =  await _cameraController.takePicture();
      Navigator.push(context, MaterialPageRoute(builder: (builder)=> CameraViewPage(path: file.path, onImageSend: widget.onImageSend,)));

  }
}
