import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'getxhomecontrooler.dart';

class GetHome extends StatelessWidget {
  GetHome({super.key});
  HomeController homeController = Get.put(HomeController());
  //HomeController homeController2 = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Column(children: [
        Obx((() {
          return Text(
            homeController.count.toString(),
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          );
        })),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  homeController.count.value = homeController.count.value + 1;
                },
                child: const Text("Increment")),
            ElevatedButton(
                onPressed: () {
                  homeController.count.value = homeController.count.value - 1;
                },
                child: const Text("Decrement")),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Obx(() => Text("Name is: ${homeController.name.value}")),
        ElevatedButton(
            onPressed: () {
              homeController.name.value = "Exd Lahore";
            },
            child: const Text("Name Update")),
        //---------------------------------;
        const SizedBox(
          height: 50,
        ),
        GetBuilder<HomeController>(builder: ((controller) {
          return Column(children: [
            Text("count:${controller.count}"),
            Text("count:${controller.name}"),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  // controller.updateValues();
                  controller.incrementValue();
                },
                child: const Text("Builder Update"))
          ]);
        }))
      ]),
    );
  }
}
