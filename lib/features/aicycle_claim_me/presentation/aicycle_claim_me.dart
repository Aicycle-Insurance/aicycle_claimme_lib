import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

enum Evn {
  dev,
  stage,
  production,
}

String? apiToken;
Evn environtment = Evn.production;
Locale? locale;
List<CameraDescription> cameras = <CameraDescription>[];
