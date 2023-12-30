import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'dart:io' as io;
import 'package:magical_music/stateManagement/controllers/musics/musicControllers.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';
import 'package:magical_music/stateManagement/models/music.dart';
import 'package:magical_music/design/widgets/listView/listItem/animatedFavoriteIcon.dart';
import 'package:magical_music/design/widgets/listView/listItem/onLongPressView.dart';
import 'package:open_filex/open_filex.dart';

class ListItem extends StatelessWidget {
  ListItem({super.key, required this.music});

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
      child: Row(children: [
        Expanded(
          child: GetBuilder<MusicControllers>(
            init: MusicControllers(),
            initState: (_) {},
            builder: (musicController) {
              return Card(
                shape: StadiumBorder(),
                color: (musicController.selectedMusic.id == music.id)
                    ? Colors.blue.shade300
                    : Colors.blue.shade100,
                child: ListTile(
                  title: Text(music.name),
                  subtitle: Text(music.description),
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/violinGridTile.jpg",
                    ),
                  ),
                  trailing: AnimatedFavoriteIcon(
                    music: music,
                  ),

                  //  IconButton(
                  //   onPressed: () {
                  //     musicController.favorite(music);
                  //   },
                  //   icon: music.isFavorite
                  //       ? Icon(
                  //           Icons.favorite,
                  //           color: Colors.red.shade400,
                  //         )
                  //       : const Icon(
                  //           Icons.favorite_border_outlined,
                  //           color: Colors.red,
                  //         ),
                  // ),
                  onTap: () async {
                    musicController.selectMusic(music);
                    if (musicController.selectedMusic.musicAddress.isNotEmpty &&
                        io.File(musicController.selectedMusic.musicAddress)
                            .existsSync()) {
                      await OpenFilex.open(
                          musicController.selectedMusic.musicAddress);
                    }
                  },
                  onLongPress: () {
                    Get.find<MusicControllers>().selectMusic(music);
                    Get.dialog(OnLongPressView());
                  },
                ),
              );
            },
          ),
        ),
        GetBuilder<ToolController>(
          init: ToolController(),
          initState: (_) {},
          builder: (toolController) {
            return AnimatedSize(
              duration: Duration(milliseconds: 300),
              reverseDuration: Duration(milliseconds: 300),
              child: Visibility(
                maintainAnimation: true,
                maintainState: true,
                visible: toolController.checkBoxVisiblity,
                child: GetBuilder<MusicControllers>(
                  builder: (musicController) {
                    return SizedBox(
                      width:
                          toolController.checkBoxVisiblity ? Get.width / 9 : 0,
                      child: Checkbox(
                        value: musicController.selectedMusics.contains(music),
                        onChanged: (val) {
                          if (val == true) {
                            musicController.addSelectedMusics(music);
                          } else {
                            if (musicController.selectedMusics
                                .contains(music)) {
                              musicController.removeSelectedMusics(music);
                            }
                          }
                        },
                        shape: CircleBorder(),
                        checkColor: Colors.green,
                        activeColor: Colors.lightGreen.shade300,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        )
      ]),
    );
  }
}
