import 'notes_fact.dart';

class Notes {
  final int id;
  final String name;
  final String imagePath;
  final String userItinerarySummary;
  final String shortDesc;
  final List<NotesFact> facts;

  Notes(
      {this.id,
      this.name,
      this.imagePath,
      this.userItinerarySummary,
      this.shortDesc,
      this.facts});

  static List<Notes> fetchAll() {
    return [
      Notes(
          id: 1,
          name: 'ICM',
          imagePath: 'assets/images/logo.jpg',
          userItinerarySummary: 'Day 1: 9AM - 1:30PM',
          shortDesc: 'Flutter Introduction',
          facts: [
            NotesFact('Summary',
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
            NotesFact('Doubts',
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
          ]),
      Notes(
          id: 2,
          name: 'TQS',
          imagePath: 'assets/images/logo.jpg',
          userItinerarySummary: 'Day 1: 9AM - 1:30PM',
          shortDesc: 'Spring Boot',
          facts: [
            NotesFact('Summary',
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
            NotesFact('Doubts',
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
          ]),
      Notes(
          id: 3,
          name: 'PI',
          imagePath: 'assets/images/logo.jpg',
          userItinerarySummary: 'Day 1: 2PM - 3:30PM',
          shortDesc: 'Milestone 3',
          facts: [
            NotesFact('Summary',
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
            NotesFact('Doubts',
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
          ]),
    ];
  }

  static Notes fetchById(int notesID) {
    // fecth all Notess;
    // iterate them and when we find the Notes
    // with the ID we want, return it immediately

    List<Notes> notes = Notes.fetchAll();
    for (var i = 0; i < notes.length; i++) {
      if (notes[i].id == notesID) {
        return notes[i];
      }
    }
    return null;
  }
}
