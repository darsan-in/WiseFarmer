import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'camera.dart';
import 'report.dart';
import 'scan.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

dynamic vh;
dynamic vw;
Color basecolor = const Color.fromRGBO(15, 80, 246, 1);
Color seccolor = const Color.fromRGBO(216, 216, 216, 1);
int currentInd = 0;

List<Widget> screens = [homepage(), scan(), const Report()];

void setleafname(val) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('leafname', val);
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    vh = MediaQuery.of(context).size.height;
    vw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: seccolor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Plant Doctor",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
      body: screens[currentInd],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: seccolor,
        currentIndex: currentInd,
        elevation: 0,
        selectedLabelStyle: const TextStyle(color: Colors.red),
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (value) async {
          if (value == 1) {
            /* print(1); */
            await availableCameras().then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
          } else {
            setState(() {
              currentInd = value;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 35,
                backgroundColor: basecolor,
                child: Image.asset(
                  'images/home.png',
                  height: vh / 100 * 5,
                ),
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 35,
                backgroundColor: basecolor,
                child: Image.asset(
                  'images/scan.png',
                  height: vh / 100 * 5,
                ),
              ),
              label: "Scan"),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 35,
              backgroundColor: basecolor,
              child: Image.asset(
                'images/report.png',
                height: vh / 100 * 5,
              ),
            ),
            label: "Report",
          )
        ],
      ),
    );
  }
}

Widget homepage() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              GestureDetector(
                onTap: () {
                  /* print("tomato"); */
                  setleafname('tomato');
                },
                child: CircleAvatar(
                  backgroundColor: seccolor,
                  radius: vw / 100 * 20,
                  child: CircleAvatar(
                    radius: vw / 100 * 18,
                    backgroundImage: const AssetImage(
                      'images/tomato.jpg',
                    ),
                  ),
                ),
              ),
              const Text(
                "Tomato",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )
            ]),
            Column(children: [
              GestureDetector(
                onTap: () {
                  /* print("rice"); */
                  setleafname('rice');
                },
                child: CircleAvatar(
                  backgroundColor: seccolor,
                  radius: vw / 100 * 20,
                  child: CircleAvatar(
                    radius: vw / 100 * 18,
                    backgroundImage: const AssetImage(
                      'images/rice.jpg',
                    ),
                  ),
                ),
              ),
              const Text(
                "Rice",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )
            ])
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              GestureDetector(
                onTap: () {
                  /* print("potato"); */
                  setleafname('potato');
                },
                child: CircleAvatar(
                  backgroundColor: seccolor,
                  radius: vw / 100 * 20,
                  child: CircleAvatar(
                    radius: vw / 100 * 18,
                    backgroundImage: const AssetImage(
                      'images/potato.jpg',
                    ),
                  ),
                ),
              ),
              const Text(
                "Potato",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )
            ]),
            Column(children: [
              GestureDetector(
                onTap: () {
                  /* print("maize"); */
                  setleafname('maize');
                },
                child: CircleAvatar(
                  backgroundColor: seccolor,
                  radius: vw / 100 * 20,
                  child: CircleAvatar(
                    radius: vw / 100 * 18,
                    backgroundImage: const AssetImage(
                      'images/maize.jpg',
                    ),
                  ),
                ),
              ),
              const Text(
                "Maize",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )
            ])
          ],
        ),
      ],
    ),
  );
}
