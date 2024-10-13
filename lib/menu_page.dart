import 'package:flutter/material.dart';
import 'package:flutter_application_1/next_page.dart';
import 'package:flutter_application_1/sound_recorder_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SoundRecorderPage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 54, 98),
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                width: 300,
                child: Center(
                  child: Text(
                    "Real Time Auscultation",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NextPage(
                            title: "Pre Recorded",
                          )),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 54, 98),
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                width: 300,
                child: Center(
                  child: Text(
                    "Pre Recorded",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NextPage(
                            title: "Pre Recorded",
                          )),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 54, 98),
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                width: 300,
                child: Center(
                  child: Text(
                    "Ai Powerd Diagnosis",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
