import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:magical_music/stateManagement/controllers/musicControllers.dart';
import 'package:magical_music/widgets/musicBottomNavigation.dart';
import 'package:magical_music/widgets/musicFloatingButton.dart';
import '../stateManagement/controllers/toolControllers.dart';
import '../tools/enums/bottomNavigationMode.dart';
import '../tools/enums/crudMode.dart';
import '../widgets/addView.dart';
import '../widgets/musicAppBar.dart';
import '../widgets/musicDrawer.dart';
import '../widgets/listView/musicView.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/images/tile_background.png',
        width: Get.width,
        height: Get.height,
        fit: BoxFit.fill,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MusicAppBar(),
        drawer: MusicDrawer(),
        floatingActionButton: MusicFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: MusicBottomNavigation(),
        body: MusicView(),
      ),
    ]);
  }
}
