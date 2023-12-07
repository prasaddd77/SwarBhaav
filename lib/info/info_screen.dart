import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../sign_in/sign_in_screen.dart';
import 'components/article_tile.dart';

class InfoScreen extends StatefulWidget {
  static String routeName = "/info";
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  Map<String, dynamic>? jsonData;

  Future<void> loadData() async {
    String jsonString =
        await rootBundle.loadString("assets/data/articles.json");

    jsonData = json.decode(jsonString);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: "स्वर",
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
            children: [
              TextSpan(
                  text: "Bhaav", style: TextStyle(color: Colors.blue[900])),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, bottom: 10),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const SignInScreen(),
                  ),
                );
              },
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: jsonData == null
            ? const CircularProgressIndicator()
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: jsonData?["articles"]?.length ?? 0,
                itemBuilder: (context, index) {
                  final article = jsonData?["articles"]?[index];
                  return ArticleTile(
                    url: article["url"],
                    imgUrl: article["urlToImage"],
                    title: article["title"],
                    desc: article["description"],
                  );
                },
              ),
      ),
    );
  }
}
