import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:song_lyrics/constants/helpers.dart';
import 'package:song_lyrics/models/lyrics_model.dart';
import 'package:song_lyrics/pages/lyrics/lyrics_page.dart';
import 'package:song_lyrics/services/lyrics_service.dart';
import 'package:song_lyrics/services/lyrics_storage_service.dart';
import 'package:song_lyrics/services/text_service.dart';
import 'package:song_lyrics/widgets/custom_text_form_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController artistNameController = TextEditingController();
  TextEditingController songTitleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String result = '';
  bool isLoading = false;
  final TextService _textService = TextService();
  final LyricsStorageService _lyricsStorageService = LyricsStorageService();

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  Future<void> _onSearchPessed() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
          result = '';
        });
        debugPrint("Loging in");
        LyricsModel lyricsResult = LyricsModel(
          artistName: _textService.capitalize(artistNameController.text.trim()),
          songTitle: _textService.capitalize(songTitleController.text.trim()),
        );
        final lyrics = await LyricsService().searchSongLyrics(lyricsResult);

        if (lyrics == 'No lyrics found') {
          setState(() {
            result =
                "$lyrics for '${lyricsResult.songTitle}' by '${lyricsResult.artistName}'.";
            isLoading = false;
          });
        } else {
          await _lyricsStorageService.saveLyrics(lyricsResult);
          if (!mounted) return;
          Helpers.goTo(context, LyricsPage(lyricsResult: lyricsResult));
        }
      }
    } catch (error) {
      debugPrint("Error $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: const Text(
          "Search a song's lyrics",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    customTextFormField(
                      labelText: "Artist's name",
                      fieldController: artistNameController,
                    ),
                    customTextFormField(
                      labelText: "Song's title",
                      fieldController: songTitleController,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 25),
              width: 200,
              child: FloatingActionButton(
                elevation: 1,
                onPressed: () {
                  _onSearchPessed();
                },
                child: const Text(
                  "Search lyrics",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
            isLoading
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 25),
                      child: const CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        child: Text(
                          result,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
            Spacing.vertical,
          ],
        ),
      ),
    );
  }
}
