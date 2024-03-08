import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/screens/add_note_screen.dart';
import 'package:noteapp/utils/colors.dart';
import 'package:noteapp/widgets/custom_appbar.dart';
import 'package:noteapp/widgets/note_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Box? noteBox;

  void boxOpen() async {
    noteBox = await Hive.openBox("notes");
    setState(() {});
  }

  @override
  void initState() {
    boxOpen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: noteBox != null
          ? StreamBuilder(
              stream: noteBox!.watch(),
              builder: (context, streamSnap) {
                return FutureBuilder(
                    future: Hive.openBox("notes"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Icon(Icons.error),
                        );
                      }
                      final values = snapshot.data!.values.toList();

                      values.sort((b, a) => a["date"].compareTo(b["date"]));
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 70,
                            ),
                            CustomAppBar(values: values),
                            const SizedBox(
                              height: 10,
                            ),
                            values.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: GridView.custom(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate: SliverQuiltedGridDelegate(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 4,
                                        crossAxisSpacing: 4,
                                        repeatPattern:
                                            QuiltedGridRepeatPattern.inverted,
                                        pattern: [
                                          const QuiltedGridTile(2, 2),
                                          const QuiltedGridTile(1, 1),
                                          const QuiltedGridTile(1, 1),
                                        ],
                                      ),
                                      childrenDelegate:
                                          SliverChildBuilderDelegate(
                                        childCount: values.length,
                                        (context, index) => NoteCard(
                                          values: values[index],
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                  height: MediaQuery.of(context).size.height-200,
                                  child: const Center(
                                      child: Text(
                                        "Hiç Not Yok",
                                        style: style1,
                                      ),
                                    ),
                                ),
                          ],
                        ),
                      );
                    });
              })
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 53, 52, 121),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddNoteScreen(
                editMode: false,
                note: {},
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
