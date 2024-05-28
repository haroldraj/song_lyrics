import 'package:flutter/material.dart';
import 'package:song_lyrics/models/search_lyrics_model.dart';
import 'package:song_lyrics/services/text_service.dart';

class LyricsPage extends StatelessWidget {
  final LyricsModel lyricsResult;
  const LyricsPage({super.key, required this.lyricsResult});

  @override
  Widget build(BuildContext context) {
    final appBarTitle = TextService()
        .capitalize("${lyricsResult.artistName} - ${lyricsResult.songTitle}");
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          appBarTitle,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Expanded(
          child: SingleChildScrollView(
            child: Text(
              lyricsResult.lyrics!,
              style: const TextStyle(fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
