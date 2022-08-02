import 'package:flutter/material.dart';
import 'package:project_/constants/routes.dart';
import 'package:project_/services/auth/auth_service.dart';
import 'package:project_/views/login_Page.dart';
import 'package:project_/views/notes/home.dart';
import 'package:project_/views/notes/create_update_note.dart';
import 'package:project_/views/register_Page.dart';
import 'package:project_/views/verifiy_email_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  return const home();
                } else {
                  return const verifyemail();
                }
              } else {
                return const LoginPage();
              }
            //return const Text("done");
            default:
              return const Text("Loading");
          }
        },
      )),
      routes: {
        loginRoute: (context) => const LoginPage(),
        registerRoute: (context) => const RegisterScreen(),
        verifyEmailRoute: (context) => const verifyemail(),
        homeRoute: ((context) => const home()),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView()
      },
    );
  }
}
