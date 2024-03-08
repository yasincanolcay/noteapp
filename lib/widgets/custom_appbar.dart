import 'package:flutter/material.dart';
import 'package:noteapp/screens/settings_screen.dart';
import 'package:noteapp/utils/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.values});
  final List values;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          "assets/fonts/icons/note.png",
          width: 50,
        ),
        Column(
          children: [
            const Text(
              "Not Defteri",
              style: style1,
            ),
            Text(
              "${values.length} Adet Not",
              style: style2,
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SettingPage(),
              ),
            );
          },
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
