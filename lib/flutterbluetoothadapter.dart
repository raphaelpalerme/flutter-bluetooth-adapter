import 'dart:async';

import 'package:flutter/services.dart';

class Flutterbluetoothadapter {
  MethodChannel _channel = const MethodChannel('flutterbluetoothadapter');

  static const EventChannel _connectionStatusEventChannel =
      const EventChannel('connection_status');

  Future<String> platformVersion() async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<List<String>> getDevices() async {
    var devices = await _channel.invokeMethod('getBtDevices');
    print("HERE - ${devices}");
    return devices;
  }

  Future<String> getDevice(int index) async {
    var device = await _channel.invokeMethod('getBtDevice');
    print("HERE - ${device}");
    return device;
  }

  Future<bool> checkBluetooth() async {
    bool result = await _channel.invokeMethod('checkBt');
    print("HERE ${result}");
    return result;
  }

  Future<bool> startServer() async {
    var result = await _channel.invokeMethod('startServer');
    print("HERE ${result}");
    return true;
  }

  Future<bool> startClient(int position) async {
    var result =
        await _channel.invokeMethod('startClient', {"index": position ?? 0});
    print("HERE ${result}");
    return true;
  }

  Future<bool> sendMessage(String message) async {
    var result =
        await _channel.invokeMethod('sendMessage', {"message": message ?? ""});
    print("HERE ${result}");
    return true;
  }

  Stream<dynamic> connectionStatus() {
    return _connectionStatusEventChannel.receiveBroadcastStream();
  }
}
