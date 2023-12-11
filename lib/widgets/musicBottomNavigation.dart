import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_music/stateManagement/controllers/musicControllers.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';
import 'package:magical_music/tools/enums/bottomNavigationMode.dart';

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
            Icons.edit_rounded,
            Icons.delete_rounded,
          ],
          activeIndex: toolCtrl.navigationMode.index,
          gapLocation: GapLocation.center,
          backgroundColor: Colors.lightBlue,
          activeColor: Colors.deepOrange.shade700,
          inactiveColor: Colors.orange.shade100,
          leftCornerRadius: 25,
          rightCornerRadius: 25,
          notchSmoothness: NotchSmoothness.smoothEdge,
          onTap: (idx) {
            toolCtrl.setnavigationMode(BottomNavigationMode.values[idx]);

            switch (toolCtrl.navigationMode) {
              case BottomNavigationMode.home:
                Get.find<ToolController>().checkBoxVisible(false);
                Get.find<MusicControllers>().refreshItems();
                break;
              case BottomNavigationMode.favorite:
                Get.find<ToolController>().checkBoxVisible(false);
                Get.find<MusicControllers>().showFavorite();
                break;
              case BottomNavigationMode.edit:
                Get.find<ToolController>().checkBoxVisible(false);
                Get.find<MusicControllers>().refreshItems();

                break;
              case BottomNavigationMode.delete:
                Get.find<MusicControllers>().refreshItems();
                Get.find<ToolController>().checkBoxVisible(true);
                break;
              default:
            }
          },
        );
      },
    );
  }
}
