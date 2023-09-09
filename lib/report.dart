import 'package:flutter/material.dart';
import 'package:plantdoctor/chat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

Color basecolor = const Color.fromRGBO(15, 80, 246, 1);
Color seccolor = const Color.fromRGBO(216, 216, 216, 1);
dynamic vh;
dynamic vw;

Future<List<String?>> getReport() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  return [pref.getString('disease'), pref.getString('treatment')];
}

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _Report();
}

class _Report extends State<Report> {
  bool repgot = false;
  late List<String?> report;
  @override
  Widget build(BuildContext context) {
    vh = MediaQuery.of(context).size.height;
    vw = MediaQuery.of(context).size.width;
    vh = vh as double;
    double fontSize = (vh / 100 * 2.2);
    return Center(
        child: GestureDetector(
      onTap: () async {
        /* print('hitting'); */
        report = await getReport();
        setState(() {
          report = report;
          repgot = true;
        });
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        constraints:
            BoxConstraints(maxHeight: vh / 100 * 60, maxWidth: vw / 100 * 80),
        decoration: BoxDecoration(
            border: Border.all(width: 3, color: seccolor),
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              repgot
                  ? (report[0]!.length > 30)
                      ? report[0]!.substring(0, 30)
                      : report[0]!
                  : "Tap to fetch",
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              repgot
                  ? (report[1]!.length > 270)
                      ? report[1]!.substring(0, 270)
                      : report[1]!
                  : "Tap to fetch",
              style: TextStyle(
                fontSize: fontSize - 6,
                letterSpacing: 1,
              ),
            ),
            SizedBox(
              height: vh / 100 * 4,
            ),
            Container(
              constraints: BoxConstraints(
                  minHeight: vh / 100 * 9, minWidth: vw / 100 * 9),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: basecolor,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () async {
                        Uri url = Uri.parse("tel:1023435");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Image.asset(
                        'images/phone-call.png',
                        height: 40,
                        width: 40,
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const Chat()));
                      },
                      child: Image.asset(
                        'images/chat.png',
                        height: 40,
                        width: 40,
                      )),
                  Image.asset(
                    'images/downloading.png',
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
