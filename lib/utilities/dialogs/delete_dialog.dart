import 'package:flutter/cupertino.dart';
import 'package:project_/utilities/dialogs/generic_dialogue.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Delete',
    content: 'Are you sure you want to delete note?',
    optionsBuilder: () => {'Cancel': false, 'Yes': true},
  ).then((value) => value ?? false);
}
