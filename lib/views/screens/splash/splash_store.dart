import 'dart:async';
import 'package:flutter/material.dart';
import 'package:song_lyrics/constants/helpers.dart';
import 'package:song_lyrics/views/screens/home/home_screen.dart';

class SplashStore extends ChangeNotifier {
  void init(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Helpers.goTo(context, const HomeScreen());
    });
  }
}
