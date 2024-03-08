import 'package:hive/hive.dart';
import 'package:noteapp/model/note.dart';
import 'package:uuid/uuid.dart';

class HiveMethod {
  final String boxName = "notes";
  Future<bool> addNote(
    String title,
    String note,
  ) async {
    try {
      String id = const Uuid().v1();
      var box = await Hive.openBox(boxName);

      Note noteModel = Note(
        title: title,
        note: note,
        date: DateTime.now(),
        id: id,
      );

      await box.put(id, noteModel.toJson());
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> deleteNote(String id) async {
    try {
      var box = await Hive.openBox(boxName);
      await box.delete(id);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> updateNote(Note noteModel, String id) async {
    try {
      var box = await Hive.openBox(boxName);
      await box.put(id, noteModel.toJson());
      return true;
    } catch (err) {
      return false;
    }
  }
}
