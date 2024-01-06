import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_music/design/widgets/tabbar_view.dart';
import 'package:magical_music/stateManagement/controllers/musics/musicControllers.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';
import '../listView/musicList.dart';

class MusicView extends StatelessWidget {
  // MusicView() {
  //   selectedIndex = Get.find<ToolController>()
  //   .categories
  //   .indexOf(state.controller!.category);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TabBarMusic(
              func: () {
                Get.find<MusicControllers>().refreshItems();
              },
            ),
          ),
          Expanded(child: MusicList()),
        ],
      ),
    );
  }
}
