import 'package:flutter/material.dart';
import 'package:song_lyrics/views/screens/splash/splash_store.dart';
import 'package:provider/provider.dart';
import 'package:song_lyrics/views/widgets/loader_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashStore>(builder: (context, store, _) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        store.init(context);
      });
      return const Scaffold(body: LoaderWidget());
    });
  }
}
