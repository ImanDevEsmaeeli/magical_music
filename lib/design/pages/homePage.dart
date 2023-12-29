import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_music/design/widgets/musicBottomNavigation.dart';
import 'package:magical_music/design/widgets/musicFloatingButton.dart';
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
