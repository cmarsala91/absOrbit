
import 'package:absorbit/ParentStateExample.dart';
import 'package:absorbit/RandomWords.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';

import 'MyOrb.dart';

void main() {
  runApp(MaterialApp(
    home: MainPage(),
  ));
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Draggable(
              data: 5,
              child: ParentWidget(),
              childWhenDragging: Container(
                height: 100.0,
                width: 100.0,
              ),
              feedback: MyOrb(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.green,
                  child: DragTarget(
                    builder:
                        (context, List<int> candidateData, rejectedData) {
                      print(candidateData);
                      return Center(child: Text("Even", style: TextStyle(color: Colors.white, fontSize: 22.0),));
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                    onAccept: (data) {
                      if(data % 2 == 0) {
                        scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Correct!")));
                      } else {
                        scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Wrong!")));
                      }
                    },
                  ),
                ),
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.deepPurple,
                  child: DragTarget(
                    builder:
                        (context, List<int> candidateData, rejectedData) {
                      return Center(child: Text("Odd", style: TextStyle(color: Colors.white, fontSize: 22.0),));
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                    onAccept: (data) {
                      if(data % 2 != 0) {
                        scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Correct!")));
                      } else {
                        scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Wrong!")));
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final wordPair = WordPair.random();

  @override
  Widget build(BuildContext context) {

    return Scaffold (
      appBar: AppBar(),
      body: RandomWords(),
    );
  }
}