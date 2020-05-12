import 'package:flutter/material.dart';
import 'package:istudy/models/notes/notes.dart';
import 'package:istudy/widgets/home_tile.dart';

class TileOverlay extends StatelessWidget {
  final Notes notes;

  TileOverlay(this.notes);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
            child: NotesTile(
              notes: notes,
              darkTheme: true,
            ))
      ],
    );
  }
}
