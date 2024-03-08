class Note {
  Note({
    required this.title,
    required this.note,
    required this.date,
    required this.id,
  });

  final String title;
  final String note;
  final String id;
  final DateTime date;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        title: json['title'] as String,
        note: json["note"] as String,
        date: json["date"] as DateTime,
        id: json["id"] as String,
      );
  Map<String, dynamic> toJson() => {
        'title': title,
        'note': note,
        "id": id,
        "date": date,
      };
}
