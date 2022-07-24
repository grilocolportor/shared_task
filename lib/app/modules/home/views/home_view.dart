//

// ignore_for_file: no_leading_underscores_for_local_identifiers, invalid_use_of_protected_member, prefer_typing_uninitialized_variables, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedtask/app/data/firebase/firebase_service.dart';
import 'package:sharedtask/app/modules/taskDetails/views/task_details_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({this.token, Key? key}) : super(key: key);

  final String? token;

  // Future  initMethod(context) async {
  //   SharedPreferences dataStorage = await SharedPreferences.getInstance();
  //   token = dataStorage.getString('userToken') ?? "";
  // }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) =>  initMethod(context));

    var size, height, width;

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    HomeController homeController = Get.put(HomeController());

    final FireBaseService fbs = FireBaseService(token: token!);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15.0),
          Expanded(
            child: StreamBuilder(
              stream: fbs.query.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];

                        homeController.creatorTask.value =
                            token!.contains(documentSnapshot['userCreate'])
                                ? true
                                : false;

                        homeController.shared.value.clear();
                        homeController.shared.value =
                            documentSnapshot['shared'];

                        return Card(
                          margin: const EdgeInsets.all(5),
                          child: ListTile(
                            title: Text(documentSnapshot['taskTitle'] ?? ''),
                            subtitle:
                                Text(documentSnapshot['taskDetail'] ?? ''),
                            trailing: SizedBox(
                              width: width / 2.7,
                              child: Row(
                                children: [
                                  // Press this button to edit a single product

                                  IconButton(
                                      icon: const Icon(Icons.update),
                                      onPressed: () => Get.to(TaskDetailsView(
                                            documentSnapshot: documentSnapshot,
                                          ))), // homeController.updateTask(documentSnapshot.id)),
                                  // // This icon button is used to delete a single product
                                  homeController.creatorTask.value
                                      ? IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            homeController.deleteTask(
                                                documentSnapshot.id);
                                            homeController
                                                .deleteTaskFromUserCollection(
                                                    documentSnapshot.id);
                                          })
                                      : Container(),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.check_circle,
                                    ),
                                    onPressed: () => homeController
                                        .deleteTask(documentSnapshot.id),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Text('Add'),
          onPressed: () {
            homeController.enableAddButtom.value = false;
            //homeController.addTaskToUserCollection('');
            showModalNewtask(context, homeController);
          }),
    );
  }

  void showModalUpdateTask(BuildContext context,
      DocumentSnapshot documentSnapshot, HomeController homeController) {
    final TextEditingController _taskController = TextEditingController();
    final TextEditingController _detailsController = TextEditingController();

    _taskController.text = documentSnapshot['taskTitle'];
    _detailsController.text = documentSnapshot['taskDetail'];
    homeController.done.value = documentSnapshot['done'] ?? '';
  }

  void showModalNewtask(BuildContext context, HomeController homeController) {
    final TextEditingController _taskController = TextEditingController();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLength: 40,
                        controller: _taskController,
                        decoration: const InputDecoration(labelText: 'Task'),
                        // onChanged: (v) {
                        //   if (v.isNotEmpty) {
                        //     homeController.enableAddButtom.value = true;
                        //   } else {
                        //     homeController.enableAddButtom.value = false;
                        //   }
                        // },
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        SharedPreferences dataStorage =
                            await SharedPreferences.getInstance();
                        if (_taskController.text.isNotEmpty) {
                          homeController.taskTitle.value = _taskController.text;
                          homeController.done.value = 'todo';
                          homeController.taskDetails.value = '';
                          homeController.userCreate.value = token!;
                          homeController.shared.value.clear();
                          homeController.shared.value
                              .add(dataStorage.getString('userToken')!);
                          homeController.addNewTask();
                          _taskController.text = '';

                          // Hide the bottom sheet
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const Icon(Icons.add_task),
                      label: const Text(''),
                    ),
                  ],
                )
              ],
            ));
      },
    );
  }
}
