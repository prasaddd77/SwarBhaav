import 'dart:convert';

SentimentResponse welcomeFromJson(String str) => SentimentResponse.fromJson(json.decode(str));

String welcomeToJson(SentimentResponse data) => json.encode(data.toJson());

class SentimentResponse {
    String userId;
    String sentimentType;
    SentimentResult result;

    SentimentResponse({
        required this.userId,
        required this.sentimentType,
        required this.result,
    });

    factory SentimentResponse.fromJson(Map<String, dynamic> json) => SentimentResponse(
        userId: json["userId"],
        sentimentType: json["sentimentType"],
        result: SentimentResult.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "sentimentType": sentimentType,
        "result": result.toJson(),
    };
}

class SentimentResult {
    String openaiResponse;
    SentimentScores sentimentScores;
    List<String> positiveWords;
    List<dynamic> negativeWords;
    String startDate;
    String endDate;

    SentimentResult({
        required this.openaiResponse,
        required this.sentimentScores,
        required this.positiveWords,
        required this.negativeWords,
        required this.startDate,
        required this.endDate,
    });

    factory SentimentResult.fromJson(Map<String, dynamic> json) => SentimentResult(
        openaiResponse: json["openai_response"],
        sentimentScores: SentimentScores.fromJson(json["sentiment_scores"]),
        positiveWords: List<String>.from(json["positive_words"].map((x) => x)),
        negativeWords: List<dynamic>.from(json["negative_words"].map((x) => x)),
        startDate: json["start_date"],
        endDate: json["end_date"],
    );

    Map<String, dynamic> toJson() => {
        "openai_response": openaiResponse,
        "sentiment_scores": sentimentScores.toJson(),
        "positive_words": List<dynamic>.from(positiveWords.map((x) => x)),
        "negative_words": List<dynamic>.from(negativeWords.map((x) => x)),
        "start_date": startDate,
        "end_date": endDate,
    };
}

class SentimentScores {
    dynamic positive;
    dynamic negative;
    dynamic neutral;

    SentimentScores({
        required this.positive,
        required this.negative,
        required this.neutral,
    });

    factory SentimentScores.fromJson(Map<String, dynamic> json) => SentimentScores(
        positive: json["positive"],
        negative: json["negative"],
        neutral: json["neutral"],
    );

    Map<String, dynamic> toJson() => {
        "positive": positive,
        "negative": negative,
        "neutral": neutral,
    };
}