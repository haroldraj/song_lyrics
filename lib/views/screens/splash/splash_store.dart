import 'dart:async';
import 'package:flutter/material.dart';
import 'package:song_lyrics/constants/helpers.dart';
import 'package:song_lyrics/main.dart';

class SplashStore extends ChangeNotifier {
  void init(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Helpers.goTo(context, const MyHomePage(title: 'Flutter Demo Home Page'));
    });
  }
}
