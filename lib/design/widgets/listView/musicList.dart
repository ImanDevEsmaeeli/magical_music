import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_music/stateManagement/bindings/musicIds.dart';
import 'package:magical_music/stateManagement/controllers/musics/musicControllers.dart';
import 'package:magical_music/stateManagement/models/music.dart';
import 'package:magical_music/design/widgets/listView/listItem/listItem.dart';

class MusicList extends GetView<MusicControllers> {
  //final List<Music> _items = Get.find<MusicControllers>().items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Expanded(
          child: GetBuilder<MusicControllers>(
            id: MusicIds.musicList,
            builder: (controller) {
              return ImplicitlyAnimatedList<Music>(
                items: controller.items,
                itemBuilder: (context, animation, item, index) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: ListItem(music: item),
                  );
                },
                areItemsTheSame: (a, b) => a.id == b.id,
              );
            },
          ),
        ),
      ],
    );
  }
}
