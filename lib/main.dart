import 'dart:developer';

import 'package:first_flame_game/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'screens/welcome_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox(UserData.boxName);

  WidgetsFlutterBinding.ensureInitialized();

  log(UserData.getBestScore().toString());
  log(UserData.getLevelsCompleted().toString());
  log(UserData.getTotalGamesPlayed().toString());

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forge2D First Game!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color(0xff184e77),
          displayColor: const Color(0xff184e77),
        ),
      ),
      home: const WelcomeScreen(),
    ),
  );
}

