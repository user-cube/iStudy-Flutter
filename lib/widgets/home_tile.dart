import 'package:flutter/material.dart';
import 'package:istudy/models/notes/notes.dart';
import '../style.dart';

const NotesTileHeight = 100.0;

class NotesTile extends StatelessWidget {
  final Notes notes;
  final bool darkTheme;

  NotesTile({this.notes, this.darkTheme = false});

  @override
  Widget build(BuildContext context) {
    final textColor = this.darkTheme ? TextColorLight : TextColorDark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: DefaultPaddingHorizontal),
      height: NotesTileHeight,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notes.name.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: textColor),
            ),
            Text(
              notes.userItinerarySummary.toUpperCase(),
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              notes.shortDesc.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: textColor),
            ),
          ]),
    );
  }
}
