import 'package:flutter/material.dart';
import 'package:music_scale_app/repeated_codes.dart';
import 'package:music_scale_app/swara.dart';
import 'package:music_scale_app/arohana_avarohana.dart';
import 'package:music_scale_app/library.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void swaraPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Swara()));
  }

  void aroAvaPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ArohanaAvarohana()));
  }

  void libraryPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Library()));
  }

  Widget myBlock(String text, String pageName) {
    return Container(
      height: 17.h,
      child: Material(
        borderRadius: BorderRadius.circular(12.w),
        color: Color.fromRGBO(217, 217, 218, 1),
        child: InkWell(
            onTap: () {
              if (pageName == 'swaraPage') {
                swaraPage();
              } else if (pageName == 'aroAvaPage') {
                aroAvaPage();
              } else if (pageName == 'libraryPage') {
                libraryPage();
              }
            },
            splashColor: lightOrange,
            borderRadius: BorderRadius.circular(12.w),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  letterSpacing: 1.0,
                  color: textColor,
                ),
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 9.h,
          backgroundColor: darkOrange,
          elevation: 0.0,
          title: Center(
              child: Text(
            'Home',
            style: TextStyle(fontSize: 20.sp),
          )),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myBlock('Play Swara', 'swaraPage'),
                myBlock('Arohana and Avarohana', 'aroAvaPage'),
                myBlock('Ragas', 'libraryPage'),
              ],
            ),
          ),
        ),
      );
    });
  }
}
