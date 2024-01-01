import 'package:flutter/material.dart';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:get/get.dart';
import 'package:magical_music/stateManagement/controllers/musics/musicControllers.dart';

class MusicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MusicAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      //title: const Text("Magical music"),
      actions: [
        AnimationSearchBar(
          searchIconColor: Colors.white,
          closeIconColor: Colors.white,
          cursorColor: Colors.black54,
          searchFieldDecoration: ShapeDecoration(
            shape: StadiumBorder(),
            color: Colors.white.withOpacity(0.9),
          ),
          centerTitle: "Magical music",
          centerTitleStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
          textStyle: TextStyle(decoration: TextDecoration.none),
          searchBarWidth: (Get.width),
          isBackButtonVisible: false,
          onChanged: (onChanged) {
            Get.find<MusicControllers>().searchTxt = onChanged;
          },
          searchTextEditingController: TextEditingController(),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
