
import 'package:flutter/material.dart';
import 'package:project_/services/auth/auth_service.dart';

// ignore: camel_case_types
class verifyemail extends StatefulWidget {
  const verifyemail({Key? key}) : super(key: key);

  @override
  State<verifyemail> createState() => _verifyemailState();
}

// ignore: camel_case_types
class _verifyemailState extends State<verifyemail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("verifyemail")),
      body: Column(
        children: [
          const Text("Verify your email"),
          const Text("Click the link below if you haven't received the mail"),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text("Send email verification "),
          )
        ],
      ),
    );
  }
}
