import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:song_lyrics/constants/url_config.dart';
import 'package:song_lyrics/models/search_lyrics_model.dart';
import 'package:http/http.dart' as http;

class LyricsService {
  final Logger _logger = Logger();

  Future<String> searchSongLyrics(
      SearchLyricsModel lyricsToSearch) async {
    var url = Uri.parse(
        '${UrlConfig.apiUrl}/${lyricsToSearch.artistName}/${lyricsToSearch.songTitle}');

    _logger.i(
        "Searching lyrics of '${lyricsToSearch.songTitle}' by ${lyricsToSearch.artistName}");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      _logger.i('Lyrics found');
      var songLyrics =
          json.decode(utf8.decode(response.bodyBytes))['lyrics'] as String;
      lyricsToSearch.lyrics = songLyrics;
      return songLyrics;
    } else {
      _logger.e(response);
      throw Exception('Error');
    }
  }
}