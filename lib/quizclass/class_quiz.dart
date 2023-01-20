import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'quiz_controller.dart';

class ClassQuiz extends StatelessWidget {
  ClassQuiz({super.key});
  QuizController quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Class"),
      ),
      body: Column(
        children: [
          Obx((() {
            return Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                  color:
                      quizController.color == true ? Colors.red : Colors.amber),
            );
          })),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                quizController.changeColor();
              },
              child: const Text("Builder Update"))
        ],
      ),
    );
  }
}
