// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:project_/constants/routes.dart';
import 'package:project_/services/auth/auth_exceptions.dart';
import 'package:project_/services/auth/auth_service.dart';
import 'package:project_/utilities/dialogs/error_dialog.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        title: const Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            enableSuggestions: true,
            controller: _email,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          TextField(
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            controller: _password,
            decoration: const InputDecoration(hintText: "********"),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                await AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(
                  verifyEmailRoute,
                );
              } on EmailAlreadyInUseAuthException {
                showErrorDialog(
                  context,
                  "Email alredy in use",
                );
              } on WeakPasswordAuthException {
                showErrorDialog(
                  context,
                  "Weak Password",
                );
              } on InvalidEmailAuthException {
                showErrorDialog(
                  context,
                  "Invalid Email",
                );
              } on GenericAuthException {
                showErrorDialog(
                  context,
                  "Authentication Error",
                );
              }
            },
            child: const Text("Sign Up"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text("Log in"),
          )
        ],
      ),
    );
  }
}
