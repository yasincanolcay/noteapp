// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:noteapp/methods/hive_method.dart';
import 'package:noteapp/model/note.dart';
import 'package:noteapp/utils/custom_snack.dart';
import 'package:noteapp/widgets/dialog.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({
    super.key,
    required this.editMode,
    required this.note,
  });
  final bool editMode;
  final Map note;

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleContoller = TextEditingController();
  final TextEditingController _noteContoller = TextEditingController();
  bool ediMode = true;
  bool isThereChange = false;

  void addNote() async {
    if (_titleContoller.text.isNotEmpty && _noteContoller.text.isNotEmpty) {
      HiveMethod hive = HiveMethod();
      bool response =
          await hive.addNote(_titleContoller.text, _noteContoller.text);
      if (response) {
        //başarılı
        setState(() {
          isThereChange = false;
        });
        showSnackBar("Not Eklendi", context, Colors.green);
      } else {
        showSnackBar("Not Eklenemedi!", context, Colors.red);
        //başarısız
      }
    }
  }

  void updateNote() async {
    if (_titleContoller.text.isNotEmpty && _noteContoller.text.isNotEmpty) {
      HiveMethod hive = HiveMethod();
      Note note = Note(
        title: _titleContoller.text,
        note: _noteContoller.text,
        date: widget.note["date"],
        id: widget.note["id"],
      );
      bool response = await hive.updateNote(note, widget.note["id"]);
      if (response) {
        setState(() {
          isThereChange = false;
        });
        //başarılı
        showSnackBar("Not Güncellendi", context, Colors.green);
      } else {
        showSnackBar("Not Güncellenemedi!", context, Colors.red);
        //başarısız
      }
    }
  }

  void showDeleteWarning() {
    showDialog(
        context: context,
        builder: (context) {
          return ShowDeleteWarning(
            deletePress: deleteNote,
          );
        });
  }

  void deleteNote() async {
    HiveMethod hive = HiveMethod();
    bool response = await hive.deleteNote(widget.note["id"]);
    if (response) {
      //başarılı
      showSnackBar("Not Silindi", context, Colors.green);
      Navigator.pop(context);
    } else {
      showSnackBar("Not Silinemedi!", context, Colors.red);
      //başarısız
    }
  }

  bool chehckChange() {
    if (!isThereChange) {
      Navigator.pop(context);
      return true;
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return NoteChangeDialog(
              cancel: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              press: () {
                //kaydet veye güncelle
                if (widget.editMode) {
                  updateNote();
                } else {
                  addNote();
                }
              },
            );
          });
      return false;
    }
  }

  @override
  void initState() {
    if (widget.editMode) {
      _titleContoller.text = widget.note["title"];
      _noteContoller.text = widget.note["note"];
      ediMode = false;
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleContoller.dispose();
    _noteContoller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool response =  chehckChange();
        return await Future.value(response);
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 53, 52, 121),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 38,
              ),
              Row(
                children: [
                  IconButton(
                    splashRadius: 23,
                    onPressed: () {
                      chehckChange();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    splashRadius: 23,
                    onPressed: () {
                      setState(() {
                        ediMode = !ediMode;
                      });
                    },
                    icon: Icon(
                      ediMode ? Icons.edit : Icons.remove_red_eye_rounded,
                      color: Colors.white,
                    ),
                  ),
                  widget.editMode
                      ? IconButton(
                          splashRadius: 23,
                          onPressed: showDeleteWarning,
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        )
                      : const SizedBox(),
                  IconButton(
                    splashRadius: 23,
                    onPressed: () {
                      //kaydet veye güncelle
                      if (widget.editMode) {
                        updateNote();
                      } else {
                        addNote();
                      }
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  readOnly: !ediMode,
                  controller: _titleContoller,
                  minLines: 1,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: "Poppins"),
                  onChanged: (s) {
                    if (!isThereChange) {
                      setState(() {
                        isThereChange = true;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Başlık Giriniz...",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: !ediMode,
                  controller: _noteContoller,
                  minLines: 10,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  style:
                      const TextStyle(color: Colors.white, fontFamily: "Intel"),
                  onChanged: (s) {
                    if (!isThereChange) {
                      setState(() {
                        isThereChange = true;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Notunuzu Giriniz...",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShowDeleteWarning extends StatelessWidget {
  const ShowDeleteWarning({
    super.key,
    required this.deletePress,
  });
  final VoidCallback deletePress;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Bu Not Silinsin mi?"),
      content: const Text("Notunuz kalıcı olarak silinir."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "İptal",
          ),
        ),
        TextButton(
          onPressed: deletePress,
          child: const Text(
            "Sil",
          ),
        ),
      ],
    );
  }
}
