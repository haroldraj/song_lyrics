import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:song_lyrics/models/lyrics_model.dart';

class LyricsStorageService {
  final Logger _logger = Logger();

  Future<void> saveLyrics(LyricsModel lyrics) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedLyricsList = await getSavedLyrics();
    if (!lyricsExists(lyrics, savedLyricsList)) {
      _logger.i("Saving $lyrics");
      savedLyricsList.add(jsonEncode(lyrics.toJson()));
      await prefs.setStringList('savedLyrics', savedLyricsList);
    }
  }

  Future<List<String>> getSavedLyrics() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedLyricsList = prefs.getStringList('savedLyrics') ?? [];
    return savedLyricsList;
  }

  bool lyricsExists(LyricsModel lyrics, List<String> savedLyricsList) {
    for (String savedLyrics in savedLyricsList) {
      LyricsModel savedLyricsModel =
          LyricsModel.fromJson(jsonDecode(savedLyrics));
      if (savedLyricsModel.artistName == lyrics.artistName &&
          savedLyricsModel.songTitle == lyrics.songTitle) {
        return true;
      }
    }
    return false;
  }
}
