import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:plantdoctor/server.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:plantdoctor/client.dart';

Color basecolor = const Color.fromRGBO(15, 80, 246, 1);
Color seccolor = const Color.fromRGBO(216, 216, 216, 1);

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);
  final XFile picture;

  Future<String?> getleafname() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('leafname');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Preview',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: seccolor,
        elevation: 0,
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
          const SizedBox(height: 24),
          const Text(
            "Can we proceed this?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  /* print("File sent"); */
                  dynamic nav = Navigator.of(context);
                  nav.pop();
                  nav.pop();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Report on the way"),
                  ));
                  String? leafname = await getleafname();
                  sendtoserver('192.168.29.2', 8000, leafname!, picture.path);
                  getOP();
                },
                child: CircleAvatar(
                  backgroundColor: basecolor,
                  radius: 30,
                  child: const Icon(
                    Icons.done,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  /* print("File declined"); */
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundColor: basecolor,
                  radius: 30,
                  child: const Icon(
                    Icons.close,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
