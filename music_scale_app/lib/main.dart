import 'package:flutter/material.dart';
import 'package:music_scale_app/home.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Music Scale App',
          debugShowCheckedModeBanner: false,
          home: Home(),
          theme: ThemeData(
            accentColor: Colors.black12,
            primaryColor: Color.fromRGBO(238, 98, 49, 1),
          ),
        );
      },
    );
  }
}
