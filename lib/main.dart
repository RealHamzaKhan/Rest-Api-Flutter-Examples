import 'package:flutter/material.dart';
import 'package:rest_apis/signup_api.dart';
import 'package:rest_apis/uploadimage.dart';
import 'user_api.dart';
import 'homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UploadImage(),
    );
  }
}

