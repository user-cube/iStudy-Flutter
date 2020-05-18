import 'package:flutter/material.dart';
import 'package:istudy/drawers/student/bottomNavigation.dart';
import 'package:istudy/drawers/student/drawer.dart';
import 'package:istudy/models/notes/notes.dart';
import 'package:istudy/screens/student/home/tile_overlay.dart';
import 'package:istudy/widgets/image_banner.dart';
import 'package:istudy/app.dart';

class StudentHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notes = Notes.fetchAll();
    return Scaffold(
      appBar: AppBar(
        title: Text('My notes'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) => _itemBuilder(context, notes[index]),
      ),
      drawer: StudentDrawer(),
      bottomNavigationBar: BottomNavigatorBar(0),
    );
  }

  _onLocationTap(BuildContext context, int noteID) {
    Navigator.pushNamed(
      context,
      NoteDetailRoute,
      arguments: {"id": noteID},
    );
  }

  Widget _itemBuilder(BuildContext context, Notes location) {
    return GestureDetector(
      child: Container(
        height: 245.0,
        child: Stack(
          children: [
            ImageBanner(assetPath: location.imagePath, height: 245.0),
            TileOverlay(location),
          ],
        ),
      ),
      onTap: () => _onLocationTap(context, location.id),
    );
  }
}
