import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterbluetoothadapter/flutterbluetoothadapter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Flutterbluetoothadapter().platformVersion();
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            RaisedButton(
              onPressed: () async {
                try {
                  await Flutterbluetoothadapter().getDevices();
                } catch (err) {
                  //
                }
              },
              child: Text("LIST DEVICES"),
            ),
            RaisedButton(
              onPressed: () async {
                try {
                  await Flutterbluetoothadapter().getDevice(1);
                } catch (err) {
                  //
                }
              },
              child: Text("GET DEVICE"),
            ),
            RaisedButton(
              onPressed: () async {
                try {
                  await Flutterbluetoothadapter().checkBluetooth();
                } catch (err) {
                  //
                }
              },
              child: Text("Check BT"),
            ),
          ],
        ),
      ),
    );
  }
}