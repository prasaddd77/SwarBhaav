import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:voicesenti/home/voiceAPI/response.dart';

Future<CallResponse> sendAudioFileToBackendWithDio(PlatformFile file) async {
  final dio = Dio();

  // Define the base URL
  final baseUrl = 'https://0867-103-110-234-115.ngrok-free.app/';

  // Define the initial URL and query parameters
  final initialUrl = 'predict';
  final queryParameters = {"userid": "64ff6346bd43796bec1f48b0"};

  try {
    // Send the initial POST request with file upload
    final response = await dio.post(
      baseUrl + initialUrl,
      queryParameters: queryParameters,
      data: FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path!,
          filename: file.name,
        ),
      }),
    );

    if (response.statusCode == 307) {
      // Handle redirection
      final redirectionUrl = response.headers['location']?.first;
      if (redirectionUrl != null) {
        final redirectedResponse = await dio.post(
          baseUrl + redirectionUrl,
          data: FormData.fromMap({
            'file': await MultipartFile.fromFile(
              file.path!,
              filename: file.name,
            ),
          }),
        );

        if (redirectedResponse.statusCode == 200) {
          final jsonResponse = redirectedResponse.data;
          print(jsonResponse);
          return CallResponse.fromJson(jsonResponse);
        } else {
          print("Error: ${redirectedResponse.statusCode}");
          throw Exception('Failed to load data');
        }
      } else {
        print("Redirection URL not found");
        throw Exception('Redirection URL not found');
      }
    } else if (response.statusCode == 200) {
      // Handle the 200 OK response without redirection
      final jsonResponse = response.data;
      print(jsonResponse);
      return CallResponse.fromJson(jsonResponse);
    } else {
      print("Error: ${response.statusCode}");
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print("Exception: $e");
    throw Exception('Failed to load data');
  }
}

Future<CallResponse> sendAudioFileToBackendWithRetry(PlatformFile file) async {
  int maxRetries = 5; // Maximum number of retries
  for (int retryCount = 0; retryCount < maxRetries; retryCount++) {
    try {
      final response = await sendAudioFileToBackendWithDio(file);
      return response;
    } catch (e) {
      print("Retry $retryCount: Exception $e");
      await Future.delayed(
          Duration(seconds: 2)); // Wait for a moment before retrying
    }
  }

  throw Exception('Failed to load data after multiple retries');
}
