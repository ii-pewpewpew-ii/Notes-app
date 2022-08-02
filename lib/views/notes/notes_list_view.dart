import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project_/services/cloud/cloud_note.dart';
import '../../utilities/dialogs/delete_dialog.dart';

typedef NoteCallback = void Function(CloudNote note);

class NotesListView extends StatelessWidget {
  const NotesListView({
    Key? key,
    required this.notes,
    required this.onDeleteNote,
    required this.onTap,
  }) : super(key: key);
  final NoteCallback onTap;
  final NoteCallback onDeleteNote;
  final Iterable<CloudNote> notes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final note = notes.elementAt(index);
        return Slidable(
          endActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (context) async {
                  final shouldDelete = await showDeleteDialog(context);
                  if (shouldDelete) {
                    onDeleteNote(note);
                  }
                },
                icon: Icons.delete,
                backgroundColor: Colors.red,
              )
            ],
          ),
          child: ListTile(
            onTap: (){
              onTap(note);
            },
            title: Text(
              note.text,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
      itemCount: notes.length,
    );
  }
}
