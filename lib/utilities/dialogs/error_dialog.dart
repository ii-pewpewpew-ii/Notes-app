import 'package:flutter/cupertino.dart';
import 'package:project_/utilities/dialogs/generic_dialogue.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showGenericDialog<void>(
    context: context,
    title: 'An error has Occured',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
