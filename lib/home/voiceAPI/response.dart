import 'package:meta/meta.dart';
import 'dart:convert';


class CallResponse {
    final String emotion;

    CallResponse({
        required this.emotion,
    });

    factory CallResponse.fromJson(Map<String, dynamic> json) => CallResponse(
        emotion: json["emotion"],
    );

    Map<String, dynamic> toJson() => {
        "emotion": emotion,
    };
}