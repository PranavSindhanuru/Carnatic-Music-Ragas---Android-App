import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_scale_app/repeated_codes.dart';
import 'package:animations/animations.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

String tempRaga = ''; // this global variable is important

Widget classification(String arohana, String avarohana) {
  if (varjyaRaga(arohana) == '' || varjyaRaga(avarohana) == '') {
    return Text(
      'no classification',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.sp,
        letterSpacing: 1.0,
        color: textColor,
      ),
    );
  } else if ((varjyaRaga(arohana) == 'sampoorna' && varjyaRaga(avarohana) == 'sampoorna')) {
    return Text(
      'sampoorna rAga',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.sp,
        letterSpacing: 1.0,
        color: textColor,
      ),
    );
  } else {
    return Text(
      '${varjyaRaga(arohana)} - ${varjyaRaga(avarohana)} rAga',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.sp,
        letterSpacing: 1.0,
        color: textColor,
      ),
    );
  }
}

Widget vakraOrNotLine(String arohana, String avarohana) {
  if (vakra(arohana, avarohana) != '') {
    return Text(
      vakra(arohana, avarohana),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.sp,
        letterSpacing: 1.0,
        color: textColor,
      ),
    );
  } else {
    return SizedBox(
      height: 0.0,
    );
  }
}

class JanakaRagaPage extends StatefulWidget {
  const JanakaRagaPage({Key? key}) : super(key: key);

  @override
  _JanakaRagaPageState createState() => _JanakaRagaPageState();
}

class _JanakaRagaPageState extends State<JanakaRagaPage> {
  AudioCache player = AudioCache(prefix: 'assets/notes/');
  bool touchScreen = false;
  String pitchValue = 'C';
  String arohana = arohanaJanaka[ragaName.indexOf(tempRaga)];
  String avarohana = avarohanaJanaka[ragaName.indexOf(tempRaga)];

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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return AbsorbPointer(
          absorbing: touchScreen,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 9.h,
              backgroundColor: Color.fromRGBO(238, 98, 49, 1),
              elevation: 0.0,
              title: Text(
                tempRaga,
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Janaka Raga',
                      style: TextStyle(
                        fontSize: 30.sp,
                        letterSpacing: 1.0,
                        color: textColor,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
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
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Arohana',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    letterSpacing: 1.0,
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  arohana,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    letterSpacing: 1.0,
                                    color: textColor,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Avarohana',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    letterSpacing: 1.0,
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  avarohana,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    letterSpacing: 1.0,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Classification',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    letterSpacing: 1.0,
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  'sampoorna rAga',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    letterSpacing: 1.0,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      playButtonAction();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Play',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: darkOrange,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 0.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class JanyaRagaPage extends StatefulWidget {
  const JanyaRagaPage({Key? key}) : super(key: key);

  @override
  _JanyaRagaPageState createState() => _JanyaRagaPageState();
}

class _JanyaRagaPageState extends State<JanyaRagaPage> {
  AudioCache player = AudioCache(prefix: 'assets/notes/');
  bool touchScreen = false;
  String pitchValue = 'C';
  String arohana = arohanaJanya[ragaName.indexOf(tempRaga) - 72];
  String avarohana = avarohanaJanya[ragaName.indexOf(tempRaga) - 72];

  void loadNotes() {
    player.loadAll([
      'g2.mp3',
      'gs2.mp3',
      'a2.mp3',
      'as2.mp3',
      'b2.mp3',
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
    } else if (note == 'N3↓') {
      if (modernNotes[(lablePitch.indexOf(pitchValue)) + 11].contains('4')) {
        player.play(modernNotes[(lablePitch.indexOf(pitchValue)) + 11]
            .replaceFirst('4', '3'));
      } else {
        player.play(modernNotes[(lablePitch.indexOf(pitchValue)) + 11]
            .replaceFirst('3', '2'));
      }
    } else if (note == 'D3↓') {
      if (modernNotes[(lablePitch.indexOf(pitchValue)) + 10].contains('4')) {
        player.play(modernNotes[(lablePitch.indexOf(pitchValue)) + 10]
            .replaceFirst('4', '3'));
      } else {
        player.play(modernNotes[(lablePitch.indexOf(pitchValue)) + 10]
            .replaceFirst('3', '2'));
      }
    } else if (note == 'D2↓') {
      if (modernNotes[(lablePitch.indexOf(pitchValue)) + 9].contains('4')) {
        player.play(modernNotes[(lablePitch.indexOf(pitchValue)) + 9]
            .replaceFirst('4', '3'));
      } else {
        player.play(modernNotes[(lablePitch.indexOf(pitchValue)) + 9]
            .replaceFirst('3', '2'));
      }
    } else if (note == 'P↓') {
      if (modernNotes[(lablePitch.indexOf(pitchValue)) + 7].contains('4')) {
        player.play(modernNotes[(lablePitch.indexOf(pitchValue)) + 7]
            .replaceFirst('4', '3'));
      } else {
        player.play(modernNotes[(lablePitch.indexOf(pitchValue)) + 7]
            .replaceFirst('3', '2'));
      }
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return AbsorbPointer(
          absorbing: touchScreen,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 9.h,
              backgroundColor: Color.fromRGBO(238, 98, 49, 1),
              elevation: 0.0,
              title: Text(
                tempRaga,
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Janya Raga',
                      style: TextStyle(
                        fontSize: 30.sp,
                        letterSpacing: 1.0,
                        color: textColor,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
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
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Arohana',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    letterSpacing: 1.0,
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  arohana,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    letterSpacing: 1.0,
                                    color: textColor,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Avarohana',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    letterSpacing: 1.0,
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  avarohana,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    letterSpacing: 1.0,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Classification',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    letterSpacing: 1.0,
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                classification(arohana, avarohana),
                                Text(
                                  upangaBhashanga(tempRaga),
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    letterSpacing: 1.0,
                                    color: textColor,
                                  ),
                                ),
                                vakraOrNotLine(arohana, avarohana),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      playButtonAction();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Play',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: darkOrange,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 0.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget cell(String raga) {
  return OpenContainer(
    closedBuilder: (context, action) {
      return Container(
        height: 10.h,
        child: Material(
          color: Color.fromRGBO(217, 217, 218, 1),
          child: Center(
            child: Text(
              raga,
              style: TextStyle(
                fontSize: 22.sp,
                letterSpacing: 1.0,
                color: textColor,
              ),
            ),
          ),
        ),
      );
    },
    openBuilder: (context, action) {
      if (ragaName.indexOf(raga) < 72) {
        tempRaga = raga;
        return JanakaRagaPage();
      } else {
        tempRaga = raga;
        return JanyaRagaPage();
      }
    },
  );
}

class RagaSearch extends SearchDelegate {
  List<String> ragaName;
  String selectedResult = '';

  RagaSearch(this.ragaName);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(
            Icons.close,
            size: 5.w,
          ),
          onPressed: () {
            query = "";
          }),
      SizedBox(
        width: 2.w,
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestedRagaName = [];
    query.isEmpty
        ? suggestedRagaName = ragaName
        : suggestedRagaName.addAll(ragaName.where(
          (element) => element.toLowerCase().contains(query.toLowerCase()),
    ));
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            Divider(
              height: 10.0,
              color: Colors.transparent,
            ),
        itemBuilder: (context, index) {
          return cell(suggestedRagaName[index]);
        },
        itemCount: suggestedRagaName.length,
      ),
    );
  }
}

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 9.h,
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: RagaSearch(ragaNameDisplay));
                  },
                  icon: Icon(
                    Icons.search,
                    size: 5.w,
                  )),
              SizedBox(
                width: 2.w,
              ),
            ],
            backgroundColor: Color.fromRGBO(238, 98, 49, 1),
            elevation: 0.0,
            title: Text(
              'Ragas',
              style: TextStyle(fontSize: 20.sp),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(10.0),
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  Divider(
                    height: 10.0,
                    color: Colors.transparent,
                  ),
              itemBuilder: (context, index) {
                ragaNameDisplay.sort();
                return cell(ragaNameDisplay[index]);
              },
              itemCount: ragaName.length,
            ),
          ),
        );
      },
    );
  }
}
