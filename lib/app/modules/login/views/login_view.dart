// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharedtask/app/modules/login/controllers/login_controller.dart';
import 'package:sharedtask/app/modules/signup/views/signup_view.dart';

import '../../home/views/home_view.dart';

class LoginView extends GetView<LoginController> {
  final LoginController loginController = Get.put(LoginController());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    loginController.getToken();
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
                await loginController
                    .loginUser(
                        email: _emailController.text,
                        password: _passwordController.text)
                    .then((value) {
                  value.fold((l) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l.toString()),
                      ),
                    );
                  }, (r) {
                    loginController.readUser();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            HomeView(),
                      ),
                    );
                  });
                });
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 30.0),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SignUpView(),
                  ),
                );
              },
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
