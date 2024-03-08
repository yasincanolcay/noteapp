// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/utils/colors.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void showWarning() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Tüm Notlar Silinsin mi?"),
            content: const Text("Bu işlem geri alınamaz!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("İptal"),
              ),
              TextButton(
                onPressed: () async {
                  var box = await Hive.openBox("notes");
                  box.clear();
                  Navigator.pop(context);
                },
                child: const Text("Sil"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    splashRadius: 23,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "Ayarlar",
                    style:style1,
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              ListTile(
                textColor: textColor,
                iconColor: textColor,
                onTap: showWarning,
                title: const Text("Tüm Notları Silin"),
                subtitle: const Text("Tüm notlar kalıcı olarak silinir!"),
                trailing: const Icon(Icons.delete),
              ),
              const Spacer(),
              const Center(child: Text("NoteApp - Youtube/canncoder")),
              const SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
