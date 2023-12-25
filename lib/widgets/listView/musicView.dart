import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_music/stateManagement/controllers/musics/musicControllers.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';
import '../listView/musicList.dart';

class MusicView extends StatelessWidget {
  List<String> labels = [];
  int selectedIndex = 0;
  final tool = Get.find<ToolController>();
  List<String> ttt = [];

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
            child: GetBuilder<ToolController>(
              init: ToolController(),
              initState: (state) {
                var tool = Get.find<ToolController>();
                selectedIndex = tool.categories.indexOf(tool.category);
              },
              builder: (controller) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 7,
                    alignment: WrapAlignment.center,
                    children: List.generate(
                      controller.categories.length,
                      (index) => ChoiceChip(
                        label: Text(controller.categories[index]),
                        labelPadding: const EdgeInsets.all(7),
                        labelStyle: TextStyle(
                          fontSize: (selectedIndex == index) ? 18 : 16,
                          color: (selectedIndex == index)
                              ? Colors.white
                              : Colors.blue.shade800,
                        ),
                        selected: selectedIndex == index,
                        selectedColor: Colors.blue,
                        backgroundColor: Colors.blue.shade50,
                        side: const BorderSide(color: Colors.blue, width: 1),
                        onSelected: (value) {
                          selectedIndex = value ? index : selectedIndex;
                          controller.setCategory(selectedIndex);
                          Get.find<MusicControllers>().refreshItems();

                          var items = Get.find<MusicControllers>().get();
                          var o = 0;
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(child: MusicList()),
        ],
      ),
    );
  }
}
