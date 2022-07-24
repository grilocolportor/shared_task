// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sharedtask/app/data/models/user_model.dart';
import '../controllers/search_users_controller.dart';

class SearchUsersView extends GetView<SearchUsersController> {
  SearchUsersView({Key? key}) : super(key: key);

  SearchUsersController searchUsersController = SearchUsersController();

  final TextEditingController searchValueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size, width;

    size = MediaQuery.of(context).size;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
          title: _searchTextField(),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back(result: searchUsersController.userListSelected);
              },
              icon: const Icon(Icons.arrow_back)),
          actions: [
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  if (searchValueController.text.isEmail) {
                    searchUsersController.search(
                        'email', searchValueController.text);
                  } else {
                    searchUsersController.search(
                        '', searchValueController.text);
                  }
                })
          ]),
      body: Column(
        children: [
          const SizedBox(height: 15.0),
          Expanded(
            child: Center(
                child: Obx(
              () => ListView.builder(
                  itemCount: searchUsersController.getList.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        searchUsersController.getList[index];
                    return Card(
                      margin: const EdgeInsets.all(5),
                      child: ListTile(
                        title: Text(documentSnapshot['userName'] ?? ''),
                        subtitle: Text(documentSnapshot['userEmail'] ?? ''),
                        trailing: SizedBox(
                          width: width / 8,
                          child: Row(
                            children: [
                              // Press this button to edit a single product

                              IconButton(
                                  icon: const Icon(
                                    Icons.check_circle,
                                  ),
                                  onPressed: () {
                                    UserModel userModel = UserModel(
                                        id: documentSnapshot.id,
                                        imagePath: documentSnapshot['imagePath'],
                                        tasks: documentSnapshot['tasks'],
                                        token: documentSnapshot['token'],
                                        userEmail:
                                            documentSnapshot['userEmail'],
                                        userName: documentSnapshot['userName']);

                                    searchUsersController
                                        .toogleButtomCheckChange(userModel);
                                  }),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )),
          ),
        ],
      ),
    );
  }

  Widget _searchTextField() {
    return TextField(
      controller: searchValueController,
      autofocus: true, //Display the keyboard when TextField is displayed
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction:
          TextInputAction.search, //Specify the action button on the keyboard
      decoration: InputDecoration(
        //Style of TextField
        enabledBorder: UnderlineInputBorder(
            //Default TextField border
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(
            //Borders when a TextField is in focus
            borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search', //Text that is displayed when nothing is entered.
        hintStyle: TextStyle(
          //Style of hintText
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }
}
