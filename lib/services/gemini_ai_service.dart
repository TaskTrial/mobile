import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiAIService {
  static final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  static  final String _endpoint =
      'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=$_apiKey';

  static final Dio _dio = Dio();

  static Future<String?> generateText(String prompt) async {
    try {
      final response = await _dio.post(
        _endpoint,
        data: {
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        final candidates = response.data['candidates'];
        if (candidates != null && candidates.isNotEmpty) {
          return candidates[0]['content']['parts'][0]['text'];
        }
        return "⚠️ Gemini API returned no content.";
      } else {
        print("❌ Gemini API error: ${response.statusCode}");
        print("Response: ${response.data}");
        return "❌ Gemini failed to generate text.";
      }
    } catch (e) {
      print("Gemini Exception: $e");
      return null;
    }
  }
}
