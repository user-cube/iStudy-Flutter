import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:istudy/drawers/student/bottomNavigation.dart';
import 'package:istudy/drawers/student/drawer.dart';
import 'package:istudy/models/notes/notes.dart';
import 'package:istudy/screens/student/home/tile_overlay.dart';
import 'package:istudy/services/note.dart';
import 'package:istudy/widgets/image_banner.dart';
import 'package:istudy/app.dart';
import 'package:istudy/widgets/loading.dart';

class StudentHome extends StatefulWidget {

  createState() => _StudentHomeState();

}

class _StudentHomeState extends State<StudentHome> {

  NotesService nservice = new NotesService();
  Future<QuerySnapshot> fut;

  @protected
  @mustCallSuper
  void initState() {
    fut = nservice.fetchAll();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('My notes'),
      ),
      body: FutureBuilder(
          future: fut,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    _itemBuilder(context, snapshot.data.documents[index]),
              );
            }
            return Loading();
          }
      ),
      drawer: StudentDrawer(),
      bottomNavigationBar: BottomNavigatorBar(0),
    );
  }

  _onLocationTap(BuildContext context, String noteID) {
    Navigator.pushNamed(
      context,
      NoteDetailRoute,
      arguments: {"id": noteID},
    );
  }

  Widget _itemBuilder(BuildContext context, DocumentSnapshot location) {
    Notes n = new Notes(id: location['id'],name: location['subject'], imagePath: location['picture'], shortDesc: location['note']);
    return GestureDetector(
      child: Container(
        height: 245.0,
        child: Stack(
          children: [
            ImageBanner(assetPath: n.imagePath, height: 245.0),
            TileOverlay(n),
          ],
        ),
      ),
      onTap: () => _onLocationTap(context, n.id),
    );
  }
}
