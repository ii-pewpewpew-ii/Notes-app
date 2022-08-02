import 'package:flutter/cupertino.dart';
import 'package:project_/utilities/dialogs/generic_dialogue.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Log out',
    content: 'Are you sure you want to log out?',
    optionsBuilder: () => {'Cancel': false, 'Logout': true},
  ).then((value) => value ?? false);
}
