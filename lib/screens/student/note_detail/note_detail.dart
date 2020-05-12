import 'package:flutter/material.dart';
import 'package:istudy/models/notes/notes.dart';
import 'package:istudy/widgets/home_tile.dart';
import 'package:istudy/widgets/image_banner.dart';
import 'text_section.dart';

class NoteDetail extends StatelessWidget {
  final int _noteID;

  NoteDetail(this._noteID);

  @override
  Widget build(BuildContext context) {
    final notes = Notes.fetchById(_noteID);

    return Scaffold(
      appBar: AppBar(
        title: Text(notes.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageBanner(assetPath: notes.imagePath),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 4.0),
                child: NotesTile(
                  notes: notes,
                ))
          ]..addAll(textSections(notes)),
        ),
      ),
    );
  }

  List<Widget> textSections(Notes notes) {
    return notes.facts
        .map((fact) => TextSection(fact.title, fact.text))
        .toList();
  }
}
