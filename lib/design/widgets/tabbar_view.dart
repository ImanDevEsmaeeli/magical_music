import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_music/stateManagement/controllers/musics/musicControllers.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';

class TabBarMusic extends StatelessWidget {
  TabBarMusic({
    super.key,
    this.func,
  }) {
    var category = Get.find<ToolController>().category;
    selectedIndex = Get.find<ToolController>()
        .categories
        .indexWhere((ctg) => ctg == category);
  }

  int? selectedIndex = 0;
  Function? func;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ToolController>(
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
                  controller.setCategory(selectedIndex!.toInt());

                  func!();

                  //
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
