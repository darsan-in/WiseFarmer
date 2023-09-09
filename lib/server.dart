import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

void getOP() async {
  final serverSocket = await ServerSocket.bind('192.168.29.4', 8000);
  print('Server listening on port 8000.');

  await for (var socket in serverSocket) {
    handleClient(socket);
  }
}

void handleClient(Socket socket) {
  print(
      'Client connected: ${socket.remoteAddress.address}:${socket.remotePort}');

  socket.listen((data) {
    final jsonData = jsonDecode(utf8.decode(data));
    print('Received JSON data: $jsonData');
    setReportData(jsonData['disease'], jsonData['treatment']);
  }, onError: (error) {
    print('Error: $error');
    socket.destroy();
  }, onDone: () {
    print('Client disconnected.');
    socket.destroy();
  });
}

void setReportData(disease, treatment) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('disease', disease);
  pref.setString('treatment', treatment);
  print('report updated');
}
