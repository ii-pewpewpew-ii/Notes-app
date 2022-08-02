// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project_/constants/routes.dart';
import 'package:project_/services/auth/auth_exceptions.dart';
import 'package:project_/services/auth/auth_service.dart';
import '../utilities/dialogs/error_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            enableSuggestions: true,
            controller: _email,
            decoration: const InputDecoration(
              hintText: "Email",
            ),
          ),
          TextField(
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            controller: _password,
            decoration: const InputDecoration(
              hintText: "********",
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().login(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    homeRoute,
                    (route) => false,
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                    (route) => false,
                  );
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(
                  context,
                  "User Not Found",
                );
              } on WrongPasswordAuthException {
                await showErrorDialog(
                  context,
                  "Invalid Password",
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  "Authentication Error",
                );
              }
            },
            child: const Text("Login"),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text("Register Here"))
        ],
      ),
    );
  }
}
