import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_music/stateManagement/controllers/musicControllers.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';
import 'package:magical_music/stateManagement/models/music.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.music});

  final Music music;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      onDismissed: (direction) {
        Get.defaultDialog(
          title: "Attention",
          content: Text("Are you sure want to delete ${music.name}"),
          onCancel: () {
            Get.find<MusicControllers>().refreshItems();
          },
          onConfirm: () {
            Get.find<MusicControllers>().delete(music);
            Get.close(1);
          },
        );
      },
      background: const Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          trailing: Icon(
            Icons.delete,
            size: 30,
            color: Colors.red,
          ),
        ),
      ),
      child: GetBuilder<ToolController>(
        builder: (toolController) => Row(children: [
          Expanded(
            child: Card(
              color: Colors.blue.shade100,
              child: ListTile(
                title: Text(music.name),
                subtitle: Text(music.description),
                leading: const CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/violinGridTile.jpg",
                  ),
                ),
                trailing: GetBuilder<MusicControllers>(
                  init: MusicControllers(),
                  initState: (_) {},
                  builder: (musicController) {
                    return IconButton(
                      onPressed: () {
                        musicController.favorite(music);
                      },
                      icon: music.isFavorite
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red.shade400,
                            )
                          : const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.red,
                            ),
                    );
                  },
                ),
              ),
            ),
          ),
          Visibility(
            visible: toolController.checkBoxVisiblity,
            child: GetBuilder<MusicControllers>(
              builder: (musicController) {
                return Checkbox(
                  value: musicController.selectedMusics.contains(music),
                  onChanged: (val) {
                    if (val == true) {
                      musicController.addSelectedMusics(music);
                    } else {
                      if (musicController.selectedMusics.contains(music)) {
                        musicController.removeSelectedMusics(music);
                      }
                    }
                  },
                  shape: CircleBorder(),
                  checkColor: Colors.green,
                  activeColor: Colors.lightGreen.shade300,
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
