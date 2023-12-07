import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:voicesenti/home/voiceAPI/response.dart';

Future<CallResponse> sendAudioFileToBackend(PlatformFile file) async {
  final url = Uri.parse('https://c0e2-103-110-234-115.ngrok-free.app/predict')
      .replace(queryParameters: {"userid": "64ff6346bd43796bec1f48b0"});

  try {
    final request = http.MultipartRequest('POST', url);

    request.files.add(http.MultipartFile(
      'file',
      file.readStream!,
      file.size,
      filename: file.path,
      
    ));

    print("File Attached to Request: ${request.files.isNotEmpty}");

    print("Request Details: $request");

    final streamedResponse = await request.send();

    if (streamedResponse.statusCode == 307) {
      final redirectionUrl = streamedResponse.headers['location'];

      final redirectedRequest =
          http.MultipartRequest('POST', Uri.parse(redirectionUrl!));

      redirectedRequest.files.add(http.MultipartFile(
        'file',
        file.readStream!,
        file.size,
        filename: file.path,
      ));

      print("File Attached to Request: ${redirectedRequest.files.isNotEmpty}");

      // Send the redirected request
      final redirectedStreamedResponse = await redirectedRequest.send();

      final response =
          await http.Response.fromStream(redirectedStreamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        return CallResponse.fromJson(jsonResponse);
      } else {
        print("Error: ${response.statusCode}");
        throw Exception('Failed to load data');
      }
    } else if (streamedResponse.statusCode == 200) {
      // Handle the 200 OK response without redirection
      final response = await http.Response.fromStream(streamedResponse);
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return CallResponse.fromJson(jsonResponse);
    } else {
      print("Error: ${streamedResponse.statusCode}");
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print("Exception: $e");
    throw Exception('Failed to load data');
  }
}










