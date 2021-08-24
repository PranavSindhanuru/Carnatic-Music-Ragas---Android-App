import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_scale_app/repeated_codes.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

class ArohanaAvarohana extends StatefulWidget {
  const ArohanaAvarohana({Key? key}) : super(key: key);

  @override
  _ArohanaAvarohanaState createState() => _ArohanaAvarohanaState();
}

class _ArohanaAvarohanaState extends State<ArohanaAvarohana> {
  AudioCache player = AudioCache(prefix: 'assets/notes/');
  bool touchScreen = false;

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
      'b4.mp3'
    ]);
  }

  @override
  void initState() {
    loadNotes();
    super.initState();
  }

  String pitchValue = 'C';
  var switchPosition = 0;
  String arohana = '';
  String avarohana = '';

  List usedToMapForPlayButton = [
    'S',
    'R1',
    'R2',
    'R3',
    'G3',
    'M1',
    'M2',
    'P',
    'D1',
    'D2',
    'D3',
    'N3'
  ];

  void playNote(String note) {
    if (note == 'S↑') {
      player.play(
          modernNotes[(lablePitch.indexOf(pitchValue))].replaceFirst('3', '4'));
    } else {
      var position = usedToMapForPlayButton.indexOf(note);
      player.play(modernNotes[(lablePitch.indexOf(pitchValue)) + position]);
    }
  }

  void playButtonAction() async {
    setState(() {
      touchScreen = true;
    });
    var arohanaHere = arohana
        .replaceAll('G1', 'R2')
        .replaceAll('G2', 'R3')
        .replaceAll('N1', 'D2')
        .replaceAll('N2', 'D3');
    var avarohanaHere = avarohana
        .replaceAll('G1', 'R2')
        .replaceAll('G2', 'R3')
        .replaceAll('N1', 'D2')
        .replaceAll('N2', 'D3');
    List userArohana = arohanaHere.split(' ');
    List userAvarohana = avarohanaHere.split(' ');
    userArohana.removeWhere((element) => element == '');
    userAvarohana.removeWhere((element) => element == '');
    for (int i = 0; i < userArohana.length; i++) {
      await Future.delayed(const Duration(milliseconds: 1000));
      playNote(userArohana[i]);
    }

    for (int i = 0; i < userAvarohana.length; i++) {
      await Future.delayed(const Duration(milliseconds: 1000));
      playNote(userAvarohana[i]);
    }
    setState(() {
      touchScreen = false;
    });
  }

  updateArohana(String swara) {
    setState(() {
      if ((swara == 'backspace') && (arohana.length > 0)) {
        arohana = arohana.substring(0, arohana.length - 3);
      } else if (swara != 'backspace') {
        arohana = arohana + swara;
      }
    });
  }

  updateAvarohana(String swara) {
    setState(() {
      if ((swara == 'backspace') && (avarohana.length > 0)) {
        avarohana = avarohana.substring(0, avarohana.length - 3);
      } else if (swara != 'backspace') {
        avarohana = avarohana + swara;
      }
    });
  }

  Widget cell(String text) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: InkWell(
        splashColor: lightOrange,
        onTap: () {
          if (switchPosition == 0) {
            updateArohana('$text ');
          } else {
            updateAvarohana('$text ');
          }
        },
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            letterSpacing: 1.0,
            color: textColor,
          ),
        )),
      ),
    );
  }

  Widget classificationButton(String arohana, String avarohana) {
    if (varjyaRaga(arohana) == '' || varjyaRaga(avarohana) == '') {
      return Text(
        'no classification',
        style: TextStyle(
          fontSize: 15.sp,
          letterSpacing: 1.0,
          color: textColor,
        ),
      );
    } else if ((varjyaRaga(arohana) == 'sampoorna' && varjyaRaga(avarohana) == 'sampoorna')) {
      return Text(
        'sampoorna rAga',
        style: TextStyle(
          fontSize: 15.sp,
          letterSpacing: 1.0,
          color: textColor,
        ),
      );
    } else {
      return Text(
        '${varjyaRaga(arohana)} - ${varjyaRaga(avarohana)} rAga',
        style: TextStyle(
          fontSize: 15.sp,
          letterSpacing: 1.0,
          color: textColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Sizer(builder: (context, orientation, deviceType) {
      return AbsorbPointer(
        absorbing: touchScreen,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 9.h,
            backgroundColor: darkOrange,
            elevation: 0.0,
            title: Text(
              'Arohana Avarohana',
              style: TextStyle(fontSize: 20.sp),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          elevation: 10,
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
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Arohana:     ',
                            style: TextStyle(
                              fontSize: 15.sp,
                              letterSpacing: 1.0,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 12.2.h,
                          ),
                          Text(
                            'Avarohana: ',
                            style: TextStyle(
                              fontSize: 15.sp,
                              letterSpacing: 1.0,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 12.2.h,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 15.h,
                              child: RawScrollbar(
                                thumbColor: Colors.black12,
                                child: SingleChildScrollView(
                                  child: Text(
                                    arohana,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      letterSpacing: 1.0,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 15.h,
                              child: SingleChildScrollView(
                                child: Text(
                                  avarohana,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    letterSpacing: 1.0,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: ToggleSwitch(
                      totalSwitches: 2,
                      minHeight: 17.sp,
                      minWidth: double.infinity,
                      labels: ['Arohana', 'Avarohana'],
                      fontSize: 15.sp,
                      initialLabelIndex: switchPosition,
                      activeBgColor: [Color.fromRGBO(238, 98, 49, 1)],
                      inactiveBgColor: Color.fromRGBO(250, 212, 198, 1),
                      onToggle: (index) {
                        switchPosition = index;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text('Classification'),
                                content:
                                    classificationButton(arohana, avarohana),
                              ),
                            );
                          },
                          child: Text('Classification'),
                          style: ElevatedButton.styleFrom(
                              primary: darkOrange,
                              textStyle: TextStyle(fontSize: 15.sp))),
                      ElevatedButton(
                          onPressed: () {
                            playButtonAction();
                          },
                          child: Text('Play'),
                          style: ElevatedButton.styleFrom(
                              primary: darkOrange,
                              textStyle: TextStyle(fontSize: 15.sp))),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 6,
                      childAspectRatio: ((100 / 6).w / 10.h),
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        cell('S '),
                        cell('R1'),
                        cell('R2'),
                        cell('R3'),
                        cell('G1'),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                if (switchPosition == 0) {
                                  updateArohana('backspace');
                                } else {
                                  updateAvarohana('backspace');
                                }
                              },
                              child: Icon(
                                Icons.backspace,
                                size: 20.sp,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: darkOrange,
                              )),
                        ),
                        cell('G2'),
                        cell('G3'),
                        cell('M1'),
                        cell('M2'),
                        cell('P '),
                        cell('D1'),
                        cell('D2'),
                        cell('D3'),
                        cell('N1'),
                        cell('N2'),
                        cell('N3'),
                        cell('S↑')
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
        ),
      );
    });
  }
}
