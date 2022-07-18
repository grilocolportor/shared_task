// ignore_for_file: invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sharedtask/app/modules/searchUsers/views/search_users_view.dart';
import 'package:sharedtask/app/modules/taskshareduser/views/taskshareduser_view.dart';

import '../controllers/task_details_controller.dart';

class TaskDetailsView extends GetView<TaskDetailsController> {
  TaskDetailsView({this.documentSnapshot, Key? key}) : super(key: key);

  TaskDetailsController taskDetailsController =
      Get.put(TaskDetailsController());

  final DocumentSnapshot? documentSnapshot;

  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _taskController.text = documentSnapshot!['taskTitle'];
    _detailsController.text = documentSnapshot!['taskDetail'];
    taskDetailsController.done.value = documentSnapshot!['done'] ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskDetailsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text('Created at:'),
                    const Padding(
                      padding: EdgeInsets.only(top: 2, bottom: 2),
                      child: Text('fsfsdf'),
                    ),
                    const Text('by '),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 2, right: 5, bottom: 2),
                      child: Text(taskDetailsController.userName.value),
                    )
                  ]),
            ),
            const Text('Task:'),
            TextField(
              maxLength: 40,
              controller: _taskController,
              decoration:
                  const InputDecoration(enabledBorder: OutlineInputBorder()),
            ),
            const Text('Details:'),
            TextField(
              maxLength: 255,
              controller: _detailsController,
              maxLines: 6,
              decoration:
                  const InputDecoration(enabledBorder: OutlineInputBorder()),
            ),
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            Get.to(TaskshareduserView(
                              idTask: documentSnapshot!.id,
                            ));
                          },
                          icon: const Icon(Icons.share),
                          label: const Text('')),
                    )),
                Expanded(
                    flex: 4,
                    child: Obx(
                      () => ElevatedButton.icon(
                          onPressed: () {
                            if (taskDetailsController.done.value
                                    .compareTo('todo') ==
                                0) {
                              taskDetailsController.done.value = 'done';
                            } else if (taskDetailsController.done.value
                                .contains('done')) {
                              taskDetailsController.done.value = 'Pending';
                            } else {
                              taskDetailsController.done.value = 'todo';
                            }
                          },
                          icon: const Icon(Icons.done),
                          label: Text(taskDetailsController.done.value)),
                    )),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      taskDetailsController.id.value = documentSnapshot!.id;
                      taskDetailsController.taskDetails.value =
                          _detailsController.text;
                      taskDetailsController.taskTitle.value =
                          _taskController.text;

                      // taskDetailsController.shared.value.clear();
                       taskDetailsController.shared.value
                           .addAll(documentSnapshot!['shared']);

                      taskDetailsController.updateTask();
                      _taskController.text = '';
                      _detailsController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.update),
                    label: const Text(''),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
