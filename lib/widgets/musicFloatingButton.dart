import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_music/stateManagement/controllers/musicControllers.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';
import 'package:magical_music/stateManagement/models/music.dart';
import 'package:magical_music/tools/enums/bottomNavigationMode.dart';
import 'package:magical_music/tools/enums/crudMode.dart';
import 'package:magical_music/widgets/addView.dart';

class MusicFloatingActionButton extends StatelessWidget {
  const MusicFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ToolController>(builder: (controller) {
      // if (true) {
      //   return FloatingActionButton(
      //     onPressed: () {
      //       var musics = Get.find<MusicControllers>();
      //       if (musics.selectedMusics.isNotEmpty) {
      //         for (Music music in musics.selectedMusics) {
      //           musics.delete(music);
      //         }
      //       }
      //     },
      //     backgroundColor: Colors.yellow,
      //     child: const Icon(
      //       Icons.delete,
      //       color: Colors.red,
      //     ),
      //   );
      // } else {
      return FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AddView(mode: CrudMode.add);
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      );
      // }
    });
  }
}
