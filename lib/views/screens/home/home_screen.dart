import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:song_lyrics/constants/helpers.dart';
import 'package:song_lyrics/models/search_lyrics_model.dart';
import 'package:song_lyrics/services/lyrics_service.dart';
import 'package:song_lyrics/widgets/custom_text_form_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController artistNameController = TextEditingController();
  TextEditingController songTitleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String result = '';
  bool isLoading = false;

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
        });
        debugPrint("Loging in");
        SearchLyricsModel searchLyricsModel = SearchLyricsModel(
          artistName: artistNameController.text.trim(),
          songTitle: songTitleController.text.trim(),
        );
        final lyrics =
            await LyricsService().searchSongLyrics(searchLyricsModel);

        setState(() {
          result = lyrics;
          isLoading = false;
        });
      }
    } catch (error) {
      debugPrint("Error $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          const Text(
            'Search Song Lyrics',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                      child: Text(result),
                    ),
                  ),
                ),
          Spacing.vertical,
        ],
      ),
    ));
  }
}
