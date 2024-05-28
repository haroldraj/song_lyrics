import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:song_lyrics/constants/helpers.dart';
import 'package:song_lyrics/models/lyrics_model.dart';
import 'package:song_lyrics/pages/lyrics/lyrics_page.dart';
import 'package:song_lyrics/services/lyrics_storage_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: const Text(
          "Search history",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: LyricsStorageService().getSavedLyrics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<LyricsModel> lyricsList = snapshot.data!
                .map((item) => LyricsModel.fromJson(jsonDecode(item)))
                .toList();
            if (lyricsList.isEmpty) {
              return const Center(
                  child: Text("You haven't searched any lyrics yet"));
            } else {
              return ListView.builder(
                itemCount: lyricsList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 0.01),
                    ),
                    margin: const EdgeInsets.only(top: 1, left: 2, right: 2),
                    child: ListTile(
                      leading: Text(
                        "${(index + 1)}.",
                        style: const TextStyle(fontSize: 16),
                      ),
                      title: Text(
                        "${lyricsList[index].artistName!} - ${lyricsList[index].songTitle!}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        Helpers.goTo(context,
                            LyricsPage(lyricsResult: lyricsList[index]));
                      },
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }
}
