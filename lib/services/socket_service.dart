import 'package:chat_app/global/environment.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'auth_service.dart';

enum ServerStatus { 
  Online, 
  Offline, 
  Connecting
}

class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;

  void connect() async {

    final token = await AuthService.getToken();
    
    //Dart client
    _socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'x-token': token
      }
    });

    _socket.on('connect', (_) {
      print('connected');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      print('disconnected');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

  }

  void disconnect() {
    _socket.disconnect();
  }

  

}