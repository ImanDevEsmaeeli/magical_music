import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:get/get.dart';
import 'package:magical_music/stateManagement/controllers/musicControllers.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';
import 'package:magical_music/tools/enums/bottomNavigationMode.dart';
import 'package:open_filex/open_filex.dart';

class MusicBottomNavigation extends StatelessWidget {
  const MusicBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ToolController>(
      builder: (toolCtrl) {
        return AnimatedBottomNavigationBar(
          icons: const [
            Icons.home_rounded,
            Icons.favorite_rounded,
            Icons.play_circle_outline_rounded,
            Icons.text_snippet_rounded,
          ],
          activeIndex: toolCtrl.navigationMode.index,
          gapLocation: GapLocation.center,
          backgroundColor: Colors.lightBlue,
          activeColor: Colors.deepOrange.shade700,
          inactiveColor: Colors.orange.shade100,
          leftCornerRadius: 25,
          rightCornerRadius: 25,
          notchSmoothness: NotchSmoothness.smoothEdge,
          onTap: (idx) async {
            toolCtrl.setnavigationMode(BottomNavigationMode.values[idx]);
            MusicControllers music = Get.find<MusicControllers>();
            ToolController tool = Get.find<ToolController>();
            switch (toolCtrl.navigationMode) {
              case BottomNavigationMode.home:
                tool.checkBoxVisible(false);
                music.refreshItems();
                break;
              case BottomNavigationMode.favorite:
                tool.checkBoxVisible(false);
                music.showFavorite();
                break;
              case BottomNavigationMode.musicPlay:
                if (music.selectedMusic.musicAddress.isNotEmpty &&
                    io.File(music.selectedMusic.musicAddress).existsSync()) {
                  await OpenFilex.open(music.selectedMusic.musicAddress);
                }
                break;
              case BottomNavigationMode.text:
                if (music.selectedMusic.textAddress.isNotEmpty &&
                    io.File(music.selectedMusic.textAddress).existsSync()) {
                  await OpenFilex.open(music.selectedMusic.textAddress);
                }
                break;
              default:
            }
          },
        );
      },
    );
  }
}
