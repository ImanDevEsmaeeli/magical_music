import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_music/stateManagement/controllers/musics/musicControllers.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';
import 'package:magical_music/stateManagement/models/music.dart';
import 'package:magical_music/tools/enums/bottomNavigationMode.dart';
import 'package:magical_music/tools/enums/crudMode.dart';
import 'package:magical_music/design/widgets/addView.dart';

class MusicFloatingActionButton extends StatelessWidget {
  const MusicFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ToolController>(builder: (controller) {
      if (controller.crudMode == CrudMode.delete) {
        return Badge(
          offset: Offset(5, -5),
          largeSize: 25,
          label: SizedBox(
            width: 17,
            child: IconButton(
              iconSize: 15,
              padding: EdgeInsets.all(0),
              color: Colors.white,
              onPressed: () {
                controller.checkBoxVisible(false);
                controller.setcrudeMode(CrudMode.add);
              },
              icon: Icon(Icons.close),
            ),
          ),
          child: FloatingActionButton(
            onPressed: () {
              var musics = Get.find<MusicControllers>();
              if (musics.selectedMusics.isNotEmpty) {
                for (Music music in musics.selectedMusics) {
                  musics.delete(music);
                }
              }
              controller.checkBoxVisible(false);
              controller.setcrudeMode(CrudMode.add);
            },
            backgroundColor: Colors.yellow,
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        );
      } else {
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
      }
    });
  }
}
