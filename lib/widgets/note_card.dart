// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:noteapp/screens/add_note_screen.dart';
import 'package:noteapp/utils/colors.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({
    super.key,
    required this.values,
  });
  final values;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddNoteScreen(
              editMode: true,
              note: widget.values,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: noteCardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.values["title"],
                    overflow: TextOverflow.ellipsis,
                    style: style1,
                  ),
                  Expanded(
                    child: Text(
                      widget.values["note"],
                      style: style2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
