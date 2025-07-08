import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_trial/utils/constants.dart';

import '../../controllers/ai_chat_controller.dart';
class ChatScreen extends StatelessWidget {

  final String? initialMessage;

  const ChatScreen({super.key, this.initialMessage});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AIChatController());
    bool fullPage =false;
     if( initialMessage != null && initialMessage!.isNotEmpty) {
     fullPage = true;
      controller.inputController.text = initialMessage!;
     }
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Column(
        children: [
          if (fullPage)
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Constants.primaryColor),
                    onPressed: () {
                      controller.inputController.clear();
                      Get.back();
                    },
                  ),
                  SizedBox(width: 80 ,),
                  Text(
                    "Ai Assistant",
                    style: TextStyle(
                      fontFamily: Constants.primaryFont,
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final msg = controller.messages[index];
                final isUser = msg['sender'] == 'user';
                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Constants.primaryColor.withOpacity(0.9)
                          : Constants.transparentWhite,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      msg['text']!,
                      style: TextStyle(
                        fontFamily: Constants.primaryFont,
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            )),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.inputController,
                    maxLines: 20,
                    minLines: 1,
                    style: TextStyle(fontFamily: Constants.primaryFont),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Obx(() => controller.isLoading.value
                    ?  SizedBox(
                  height: 20,
                                      width: 20,
                      child: CircularProgressIndicator(
                                        color: Constants.primaryColor,

                                      ),
                    )
                    : IconButton(
                  icon:  Icon(Icons.send, color: Constants.primaryColor),
                  onPressed: () => controller.sendMessage(),
                ))
              ],
            ),
          ),

            fullPage? SizedBox(height: 40,):SizedBox(), // Add some space at the bottom

        ],
      ),
    );
  }
}
