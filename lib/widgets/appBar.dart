import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar appBar = AppBar(
  elevation: 0.0,
  backgroundColor: Colors.black,
  title: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text('Unsplash', style: TextStyle(color: Colors.white, fontSize: 20)),
      Text('Flutter', style: TextStyle(color: Colors.lightBlue)),
    ],
  ),
  systemOverlayStyle: const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
  ),
);
