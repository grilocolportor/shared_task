// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharedtask/app/modules/signup/controllers/signup_controller.dart';

import '../../home/views/home_view.dart';

class SignUpView extends GetView<SignupController> {
  final SignupController signupController = Get.put(SignupController());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _userNameController,
                decoration: const InputDecoration(hintText: 'Username'),
              ),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
                await signupController
                    .createUser(
                        email: _emailController.text,
                        password: _passwordController.text)
                    .then((value) {
                  signupController.userName.value = _userNameController.text;
                  signupController.userEmail.value = _emailController.text;
                  signupController.addNewUser();
                  value.fold((l) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l.toString()),
                      ),
                    );
                  }, (r) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HomeView(),
                      ),
                    );
                  });
                });
              },
              child: const Text('Create Account'),
            )
          ],
        ),
      ),
    );
  }
}
