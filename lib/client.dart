import 'dart:io';
import 'dart:typed_data';

void sendtoserver(
    String host, int port, String leafname, String imgpath) async {
  /* print('send funtion is called'); */
  final socket = await Socket.connect(host, port);

  // send leaf name
  socket.write(leafname);

  // send image data
  final imageBytes = await File(imgpath).readAsBytes();
  final imageSizeBytes = imageBytes.length.toBytes();
  socket.add(imageSizeBytes);
  socket.add(imageBytes);

  /* print('Text and image sent.'); */

  // close the socket
  socket.close();
  /* print("socket closed"); */
}

extension IntToBytes on int {
  List<int> toBytes({Endian endian = Endian.big}) {
    final byteData = ByteData(4);
    byteData.setInt32(0, this, endian);
    return byteData.buffer.asUint8List();
  }
}
