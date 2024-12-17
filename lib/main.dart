import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/welcome_screen.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'Forge2D First Game!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const WelcomeScreen(),
    ),
  );
}

