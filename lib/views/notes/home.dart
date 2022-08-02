// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_/constants/routes.dart';
import 'package:project_/services/auth/auth_service.dart';
import 'package:project_/services/cloud/cloud_note.dart';
import 'package:project_/services/cloud/firebase_cloud_storage.dart';
import 'package:project_/services/crud/notes_service.dart';
import 'package:project_/utilities/dialogs/logout_dialog.dart';
import 'package:project_/views/notes/create_update_note.dart';
import 'package:project_/views/notes/notes_list_view.dart';

import '../../enums/menu_action.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Notes"),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                final decision = await showLogoutDialog(context);
                if (decision) {
                  await AuthService.firebase().logout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (route) => false,
                  );
                }
                break;
            }
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text("logout"),
              ),
            ];
          })
        ],
      ),
      body: StreamBuilder(
              stream: _notesService.allNotes(ownerUserId: userId),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case (ConnectionState.waiting):
                  case (ConnectionState.active):
                    if (snapshot.hasData) {
                      final allNotes = snapshot.data as Iterable<CloudNote>;
                      return NotesListView(
                        notes: allNotes,
                        onDeleteNote: ((note) async {
                          await _notesService.deleteNote(documentId:note.documentId);
                        }),
                        onTap: (note) {
                          Navigator.of(context)
                              .pushNamed(createOrUpdateNoteRoute,arguments:note);
                          
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  default:
                    return const CircularProgressIndicator();
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
