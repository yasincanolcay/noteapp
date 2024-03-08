import 'package:flutter/material.dart';

class NoteChangeDialog extends StatefulWidget {
  const NoteChangeDialog({
    super.key,
    required this.press,
    required this.cancel,
  });
  final VoidCallback press;
  final VoidCallback cancel;

  @override
  State<NoteChangeDialog> createState() => _NoteChangeDialogState();
}

class _NoteChangeDialogState extends State<NoteChangeDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Kaydedilmemiş Değişiklikler Var!"),
      content: const Text("Değişiklikler kaydedilsin mi?"),
      actions: [
        TextButton(
          onPressed: widget.cancel,
          child: const Text("Hayır"),
        ),
        TextButton(
          onPressed: widget.press,
          child: const Text("Kaydet"),
        ),
      ],
    );
  }
}
