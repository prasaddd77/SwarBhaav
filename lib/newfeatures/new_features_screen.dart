import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../components/custom_navigation_drawer.dart';
import '../components/new_button.dart';
import '../home/components/sound_recorder.dart';
import '../home/components/timer_widget.dart';
import '../home/home_screen.dart';

class ComingSoonPage extends StatefulWidget {
  static String routeName = "/coming_soon";
  const ComingSoonPage({super.key});

  @override
  State<ComingSoonPage> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage> {
  final recorder = SoundRecorder();
  final timeController = TimerController();

  @override
  void initState() {
    super.initState();

    recorder.init();
  }

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRecording = recorder.isRecording;
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text(
          "Coming Soon",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Analyze Calls Manually",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 30),
          NeumorphicButton(
            margin: const EdgeInsets.only(left: 20, right: 20),
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 4,
              intensity: 0.8,
              color: Colors.blueGrey[200],
            ),
            padding: const EdgeInsets.all(30.0),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (_) => buildDialogBox(),
              );
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.mic),
                  SizedBox(width: 10),
                  Text(
                    "Record Using Mic",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Widget buildDialogBox() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 300,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NewButton(
                  text: "Start",
                  onPressed: () async {
                    await recorder.record();
                    final isRecording = recorder.isRecording;
                    setState(() {});

                    if (isRecording) {
                      timeController.startTimer();
                    }
                  },
                  icon: Icons.mic,
                ),
                NewButton(
                  text: "Stop",
                  onPressed: () async {
                    await recorder.stop();
                    final isRecording = recorder.isRecording;
                    setState(() {});

                    if (!isRecording) {
                      timeController.stopTimer();
                    }
                  },
                  icon: Icons.stop,
                ),
              ],
            ),
            const SizedBox(height: 20),
            TimerWidget(controller: timeController),

            const SizedBox(height: 20),

            NewButton(
              text: "Submit",
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icons.send,
            ),
          ],
        ),
      ),
    );
  }
}
