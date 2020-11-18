import 'package:flutter/material.dart';
import 'package:image_bay/models/main_screen_model.dart';
import 'package:image_bay/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainScreenModel>(
      create: (c) => MainScreenModel()..selectedCategoryIndex = 0,
      child: MaterialApp(
        title: 'Image Bay',
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          }),
        ),
        initialRoute: '/',
        routes: {
          '/': (c) => MainScreen(),
        },
      ),
    );
  }
}
