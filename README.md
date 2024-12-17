# Flutter Game: ShappyBirds

## Overview

Like flappy birds, but with shapes.
<br/>

This project is a simple game created with Flutter, Flame, and Forge2D, where the player controls a square that must jump to avoid balls thrown at it from the right side of the screen. The gameplay is similar to **Flappy Bird**, with a focus on dodging obstacles instead of controlling the square’s movement.

---

## Demo

https://github.com/user-attachments/assets/d1afec09-d129-4b0c-994b-e36bcf84ecb8


## Requirements Fulfilled

- ✔️ **Clear Game Purpose**: The player must avoid obstacles (balls) by jumping, creating a simple yet challenging experience.
- ✔️ **Multiple Screens**: The game includes the following screens: Welcome Screen with Level Selectio, Game Screen, and Result Screen.
- ✔️ **Responsive Layout**: The game’s layout adapts to different screen sizes and uses a fixed height approach with `FixedResolutionViewport`.
- ✔️ **Multiple Levels**: The game features three levels that differ in terms of difficulty, with the balls shown more often when the level increases.
- ✔️ **Progression Saving**: The game saves the player’s completed levels between app restarts with Hive.
- ✔️ **Touchscreen Play**: The game can be played using touchscreen gestures, without needing a keyboard or mouse.
- ✔️ **Online Location**: The game has been deployed with Vercel and can be found [here](https://first-flame-game.vercel.app/)!

---

## Other technical Details

- **Camera Component**: Instead of using `CameraComponent.withFixedResolution`, the camera viewport was set with a fixed height and adjusted resolution:
  
  ```dart
  final double width = screenSize.x > 600 ? 600 : screenSize.x;

  camera.viewport = FixedResolutionViewport(
    resolution: Vector2(width, screenSize.y),
  );
