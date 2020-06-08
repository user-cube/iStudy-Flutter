import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:istudy/models/notes/notes.dart';
import 'package:istudy/services/note.dart';
import 'package:istudy/widgets/home_tile.dart';
import 'package:istudy/widgets/image_banner.dart';
import 'package:istudy/widgets/loading.dart';
import 'text_section.dart';

class NoteDetail extends StatelessWidget {
  final String _noteID;

  NoteDetail(this._noteID);

  NotesService nservice = new NotesService();

  fetchNote() {
    return nservice.fetchById(_noteID);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Note"),
      ),
      body: FutureBuilder(
        future: fetchNote(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ImageBanner(assetPath: snapshot.data.documents[0]['picture']),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 4.0),
                      child: NotesTile(
                        notes: new Notes(
                            name: snapshot.data.documents[0]['subject']),
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      child: Text(snapshot.data.documents[0]['note']))
                ],
              ),
            );
          }
            return Loading();
    }
      )
    );
  }

  List<Widget> textSections(Notes notes) {
    return notes.facts
        .map((fact) => TextSection(fact.title, fact.text))
        .toList();
  }
}
