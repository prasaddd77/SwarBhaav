import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:voicesenti/home/textAPI/response.dart';

Future<SentimentResponse> sendFileToBackend(PlatformFile file) async {
  final url =
      Uri.parse('https://sih-node-backend.architrathod1.repl.co/user/upload');
  final request = http.MultipartRequest('POST', url)
    ..headers['token'] =
        "YOUR_TOKEN_HERE";
  request.files.add(http.MultipartFile(
      'input_file', file.readStream!, file.size,
      filename: file.name));

  try {
    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return SentimentResponse.fromJson(jsonResponse);
    } else {
      print("Error: ${response.statusCode}");
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print("Exception $e");
  }
  throw Exception('Failed to load data');
}
