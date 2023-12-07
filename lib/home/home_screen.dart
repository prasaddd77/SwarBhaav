import "dart:io";

import "package:file_picker/file_picker.dart";
import "package:flutter_neumorphic/flutter_neumorphic.dart";
import "package:voicesenti/home/textAPI/response.dart";
import "package:voicesenti/home/textAPI/text_api.dart";
import "package:voicesenti/home/voiceAPI/response.dart";
import "package:voicesenti/home/voiceAPI/voice_api.dart";
import "package:voicesenti/home/voiceAPI/voice_api2.dart";
import "../components/custom_navigation_drawer.dart";

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? filePath;
  String? emotion;
  PlatformFile? selectedFile;
  PlatformFile? selectedAudioFile;
  Future<SentimentResponse>? sentimentResponseFuture;
  Future<CallResponse>? callResponseFuture;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color(0xFFE7ECEF);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 33, 194, 243),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Column(
            children: [
              const Text(
                "Analyze Calls",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 30),
              NeumorphicButton(
                margin: const EdgeInsets.only(left: 20, right: 20),
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  depth: 4,
                  intensity: 0.8,
                  color: Colors.blueGrey[200],
                ),
                padding: const EdgeInsets.all(30.0),
                onPressed: selectAndUploadAudioFile,
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload_file),
                      SizedBox(width: 10),
                      Text(
                        "Upload From Device",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              ),
              const SizedBox(height: 30),
              // FutureBuilder<CallResponse>(
              //   future: callResponseFuture,
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       // While data is loading
              //       return const CircularProgressIndicator();
              //     } else if (snapshot.hasError) {
              //       // If there's an error
              //       return Text('Error: ${snapshot.error}');
              //     } else {
              //       // If data is successfully loaded
              //       final callResponse = snapshot.data;

              //       // Access the parsed data and display it
              //       return Padding(
              //         padding: const EdgeInsets.all(15.0),
              //         child: Text(
              //           'RESPONSE: ${callResponse?.emotion}',
              //           style: const TextStyle(
              //               fontSize: 15,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.teal),
              //         ),
              //       );
              //     }
              //   },
              // ),
              const SizedBox(height: 50),
              const Text(
                "Analyze Chats",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 30),
              NeumorphicButton(
                margin: const EdgeInsets.only(left: 20, right: 20),
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  depth: 4,
                  intensity: 0.8,
                  color: Colors.blueGrey[200],
                ),
                padding: const EdgeInsets.all(30.0),
                onPressed: selectAndUploadFile,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat),
                    SizedBox(width: 10),
                    Text(
                      "Upload Chats",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              FutureBuilder<SentimentResponse>(
                future: sentimentResponseFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While data is loading
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // If there's an error
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // If data is successfully loaded
                    final sentimentResponse = snapshot.data;

                    // Access the parsed data and display it
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'USER ID: ${sentimentResponse?.userId}',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          Text(
                            'SENTIMENT TYPE: ${sentimentResponse?.sentimentType}',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          Text(
                            'OPENAI RESPONSE: ${sentimentResponse?.result.openaiResponse}',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          ),
                          Text(
                            "SENTIMENT POSITIVE SCORE: ${sentimentResponse?.result.sentimentScores.positive}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          ),
                          Text(
                            "SENTIMENT NEGATIVE SCORE: ${sentimentResponse?.result.sentimentScores.negative}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                          ),
                          Text(
                            "SENTIMENT NEUTRAL SCORE: ${sentimentResponse?.result.sentimentScores.neutral}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                          Text(
                            "POSITIVE WORDS : ${sentimentResponse?.result.positiveWords}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Text(
                            "NEGATIVE WORDS : ${sentimentResponse?.result.negativeWords}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Text(
                            "START DATE : ${sentimentResponse?.result.startDate}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Text(
                            "END DATE : ${sentimentResponse?.result.endDate}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      drawer: const NavigationDrawerWidget(),
    );
  }

  Future<void> selectAndUploadFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["txt"],
      withReadStream: true,
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      selectedFile = file;
      setState(() {
        // Trigger a rebuild to show the selected file information
        sentimentResponseFuture = sendFileToBackend(file);
      });
    }
  }

  Future<void> selectAndUploadAudioFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      withReadStream: true,
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      print(file);
      selectedAudioFile = file;
      setState(() {
        callResponseFuture = sendAudioFileToBackendWithRetry(file);
      });
    }
  }
}

//   Future<String?> pickAudioFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.audio,
//     );

//     if (result != null) {
//       String? filePath = result.files.first.path;
//       return filePath;
//     } else {
//       return null; // User canceled file picking
//     }
//   }

//   Future<void> pickAndSendAudio() async {
//     // Step 1: Pick an audio file
//     filePath = await pickAudioFile();

//     if (filePath != null) {
//       // Step 2: Send the audio file to the API and get the emotion
//       emotion = await sendAudioFileToAPI(filePath!);
//       setState(() {}); // Update the UI
//     }
//   }
// }

