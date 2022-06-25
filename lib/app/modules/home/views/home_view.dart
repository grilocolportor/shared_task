import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Center(
            child: TextButton(
              child: const Text('Adcionar'),
              onPressed: () => _homeController.addNewTask(),
            ),
          ),
          const SizedBox(height: 15.0),
          Center(
            child: TextButton(
              child: const Text('Consultar'),
              onPressed: () => _homeController.readTasks(),
            ),
          ),
          const SizedBox(height: 15.0),
          Expanded(
            child: Center(
              child: Obx(() => ListView.builder(
                  itemCount: _homeController.taskList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_homeController.taskList[index].taskTitle ?? ""),
                    );
                  })),
            ),
          ),
        ],
      ),
    );
  }
}
