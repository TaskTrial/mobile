// ai_chat_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/gemini_ai_service.dart';

class AIChatController extends GetxController {
  final RxList<Map<String, String>> messages = <Map<String, String>>[].obs;
  final TextEditingController inputController = TextEditingController();
  final isLoading = false.obs;


  void sendMessage() async {
    final text = inputController.text.trim();
    if (text.isEmpty) return;
    messages.add({'sender': 'user', 'text': text});
    inputController.clear();
    isLoading.value = true;
    final reply = await GeminiAIService.generateText(text);
    isLoading.value = false;

    if (reply != null && reply.isNotEmpty) {
      messages.add({'sender': 'ai', 'text': reply});
    } else {
      messages.add({
        'sender': 'ai',
        'text': 'Sorry, I was unable to generate a response.'
      });
    }
  }
}
