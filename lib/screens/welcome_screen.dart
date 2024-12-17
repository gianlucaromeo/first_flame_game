import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'game_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the game!',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => GameScreen());
              },
              child: Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}