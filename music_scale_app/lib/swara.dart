import 'package:flutter/material.dart';
import 'package:music_scale_app/repeated_codes.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

class Swara extends StatefulWidget {
  const Swara({Key? key}) : super(key: key);

  @override
  _SwaraState createState() => _SwaraState();
}

class _SwaraState extends State<Swara> {
  String pitchValue = 'C';

  AudioCache player = AudioCache(prefix: 'assets/notes/');

  void playNote(String note) {
    var position = classicalNotes.indexOf(note);
    player.play(modernNotes[(lablePitch.indexOf(pitchValue)) + position]);
  }

  Widget cell(String note) {
    return Container(
      child: InkWell(
        enableFeedback: false,
        splashColor: lightOrange,
        onTap: () {
          playNote(note);
        },
        child: Center(
            child: Text(
          note,
          style: TextStyle(
            fontSize: 20.sp,
            letterSpacing: 1.0,
            color: textColor,
          ),
        )),
      ),
    );
  }

  void loadNotes() {
    player.loadAll([
      'c3.mp3',
      'cs3.mp3',
      'd3.mp3',
      'ds3.mp3',
      'e3.mp3',
      'f3.mp3',
      'fs3.mp3',
      'g3.mp3',
      'gs3.mp3',
      'a3.mp3',
      'as3.mp3',
      'b3.mp3',
      'c4.mp3',
      'cs4.mp3',
      'd4.mp3',
      'ds4.mp3',
      'e4.mp3',
      'f4.mp3',
      'fs4.mp3',
      'g4.mp3',
      'gs4.mp3',
      'a4.mp3',
      'as4.mp3',
    ]);
  }

  @override
  void initState() {
    loadNotes();
    super.initState();
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
          title: Text(
            'Play Swara',
            style: TextStyle(fontSize: 20.sp),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pitch',
                      style: TextStyle(
                        fontSize: 20.sp,
                        letterSpacing: 1.0,
                        color: textColor,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: pitchValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 25.sp,
                        elevation: 0,
                        style: TextStyle(color: textColor, fontSize: 20.sp),
                        onChanged: (String? newValue) {
                          setState(() {
                            pitchValue = newValue!;
                          });
                        },
                        items: <String>[
                          'C',
                          'C#',
                          'D',
                          'D#',
                          'E',
                          'F',
                          'F#',
                          'G',
                          'G#',
                          'A',
                          'A#',
                          'B'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(
                                    color: textColor, fontSize: 20.sp)),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Expanded(
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    childAspectRatio: ((100 / 3).w / 20.h),
                    children: [
                      cell('S'),
                      cell('R1'),
                      cell('R2 G1'),
                      cell('R3 G2'),
                      cell('G3'),
                      cell('M1'),
                      cell('M2'),
                      cell('P'),
                      cell('D1'),
                      cell('D2 N1'),
                      cell('D3 N2'),
                      cell('N3'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.0,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
