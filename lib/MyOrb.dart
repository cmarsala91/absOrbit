import 'package:flutter/material.dart';

class MyOrb extends StatefulWidget {
  @override
  _MyOrbState createState() => _MyOrbState();
}

class _MyOrbState extends State<MyOrb>{
  double radius = 100.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: ShapeDecoration(
        color: Colors.blue[500],
        shape: CircleBorder(),
      ),
      child: Counter(),
    );
  }
}


class Counter extends StatefulWidget {
  // This class is the configuration for the state. It holds the
  // values (in this case nothing) provided by the parent and used
  // by the build  method of the State. Fields in a Widget
  // subclass are always marked "final".

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      // This call to setState tells the Flutter framework that
      // something has changed in this State, which causes it to rerun
      // the build method below so that the display can reflect the
      // updated values. If you change _counter without calling
      // setState(), then the build method won't be called again,
      // and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,
    // for instance, as done by the _increment method above.
    // The Flutter framework has been optimized to make rerunning
    // build methods fast, so that you can just rebuild anything that
    // needs updating rather than having to individually change
    // instances of widgets.
    return Center(
       child: Text(
         '$_counter',
         style: TextStyle(color: Colors.white, fontSize: 22.0),
       )
    );
  }
}