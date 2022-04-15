import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class CameraProvider with ChangeNotifier{
  List<CameraDescription> cameras;

  CameraProvider(this.cameras);
}