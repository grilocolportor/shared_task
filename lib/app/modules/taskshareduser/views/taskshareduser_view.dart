// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sharedtask/app/data/firebase/firebase_service.dart';
import 'package:sharedtask/app/data/models/tasks_model.dart';
import 'package:sharedtask/app/modules/searchUsers/views/search_users_view.dart';

import '../controllers/taskshareduser_controller.dart';

class TaskshareduserView extends GetView<TaskshareduserController> {
  const TaskshareduserView({this.idTask, Key? key}) : super(key: key);

  final String? idTask;
  @override
  Widget build(BuildContext context) {

    var size,height,width;

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    TaskshareduserController taskshareduserController =
        Get.put(TaskshareduserController());
    final FireBaseService fbs = FireBaseService();
    fbs.getUserByTask(idTask!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskshareduserView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: Center(
            child: StreamBuilder(
              stream: fbs.userByTaskQuery.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        return Card(
                          margin: const EdgeInsets.all(5),
                          child: ListTile(
                            title: Text(documentSnapshot['userName'] ?? ''),
                            subtitle: Text(documentSnapshot['userEmail'] ?? ''),
                            trailing: SizedBox(
                              width: width/2.8,
                              child: Row(
                                children: [
                                  // Press this button to edit a single product
                                  // IconButton(
                                  //     icon: const Icon(Icons.update),
                                  //     onPressed: () =>
                                  //         Get.to(TaskDetailsView(
                                  //           documentSnapshot:
                                  //               documentSnapshot,
                                  //         ))), // homeController.updateTask(documentSnapshot.id)),
                                  // // // This icon button is used to delete a single product
                                  // homeController.creatorTask.value ?
                                  // IconButton(
                                  //     icon: const Icon(Icons.delete),
                                  //     onPressed: () {
                                  //       homeController.deleteTask(
                                  //           documentSnapshot.id);
                                  //       homeController
                                  //           .deleteTaskFromUserCollection(
                                  //               documentSnapshot.id);
                                  //     }) : Container(),
                                  // IconButton(
                                  //   icon: const Icon(
                                  //     Icons.check_circle,
                                  //   ),
                                  //   onPressed: () => homeController
                                  //       .deleteTask(documentSnapshot.id),
                                  // ),
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
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Text('Add'),
          onPressed: () async {
            Map<String, String> retorno = await Get.to(SearchUsersView());

            //for (var element in retorno) {cel
            retorno.forEach((key, value) async {
              if (value.isNotEmpty) {
                await taskshareduserController.updateTask(
                  taskId: idTask!,
                  users: value,
                );
              }
            });

            // }
            // for (var element in retorno) {
            retorno.forEach((key, value) async {
              if (value.isNotEmpty) {
                await taskshareduserController.addTaskToUserCollection(
                    idTask!, key);
              }
            });
          }
          //}
          ),
    );
  }
}
