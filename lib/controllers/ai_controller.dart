import 'package:get/get.dart';
import '../services/gemini_ai_service.dart';

class AIController extends GetxController {
  var isLoading = false.obs;

  Future<void> generateAIText({
    required String prompt,
    required void Function(String result) onSuccess,
    required void Function(String error) onError,
  }) async {
    isLoading.value = true;

    final result = await GeminiAIService.generateText(prompt);
    isLoading.value = false;

    if (result != null) {
      onSuccess(result);
    } else {
      onError("AI failed to generate result");
    }
  }
}
