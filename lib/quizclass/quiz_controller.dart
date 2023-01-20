import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import 'package:get/state_manager.dart';

class QuizController extends GetxController {
  RxBool color = false.obs;
  RxBool theme = false.obs;
  changeColor() {
    if (color == false) {
      color.value = true;
    } else if (Color == true) {
      color.value = false;
      update();
    }
  }
}
