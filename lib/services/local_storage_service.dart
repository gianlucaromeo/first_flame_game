
import 'package:hive_ce/hive.dart';

class UserData {
  static const String boxName = 'user_data';

  static const String bestScoreKey = 'best_score';
  static const String levelsCompletedKey = 'levels_completed';
  static const String totalGamesPlayedKey = 'total_games_played';

  static final storage = Hive.box(boxName);

  static Future<void> setBestScore(int score) async {
    await storage.put(bestScoreKey, score);
  }

  static int getBestScore() {
    return storage.get(bestScoreKey, defaultValue: 0);
  }

  static Future<void> setLevelsCompleted(int level) async {
    var currentLevels = storage.get(levelsCompletedKey, defaultValue: 0);
    if (level > currentLevels) {
      await storage.put(levelsCompletedKey, level);
    }
  }

  static int getLevelsCompleted() {
    return storage.get(levelsCompletedKey, defaultValue: 0);
  }

  static Future<void> incrementTotalGamesPlayed() async {
    int totalGames = storage.get(totalGamesPlayedKey, defaultValue: 0);
    await storage.put(totalGamesPlayedKey, totalGames + 1);
  }

  static int getTotalGamesPlayed() {
    return storage.get(totalGamesPlayedKey, defaultValue: 0);
  }
}
