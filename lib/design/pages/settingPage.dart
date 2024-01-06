import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_music/design/widgets/animated_slider_button.dart';
import 'package:magical_music/design/widgets/tabbar_view.dart';
import 'package:magical_music/stateManagement/bindings/musicIds.dart';
import 'package:magical_music/stateManagement/controllers/musics/musicControllers.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';
import 'package:magical_music/stateManagement/models/music.dart';

class SettingPage extends StatelessWidget {
  List<String> labels = [];
  ToolController tools = ToolController();
  SettingPage() {
    tools = Get.find<ToolController>();
    //labels = tools.getCategories();
  }

  String _txt = "";

  @override
  Widget build(BuildContext context) {
    //final tools = Get.find<ToolController>();

    return Scaffold(
      appBar: AppBar(title: Text("setting")),
      floatingActionButton: AnimatedSliderButton(
        addFunc: () {
          if (_txt.length != 0) {
            String? isContain = Get.find<ToolController>()
                .categories
                .firstWhereOrNull((m) => m == _txt);
            if (isContain == null) {
              tools.add(_txt);
              Get.snackbar(
                "Successful",
                "Category $_txt added successfully",
                backgroundColor: Colors.green.withOpacity(0.8),
              );
              _txt = "";
            } else {
              Get.snackbar(
                "Unsuccessful",
                "category $_txt already exist please change it's name",
                backgroundColor: Colors.red.withOpacity(0.8),
                duration: Duration(seconds: 5),
              );
            }
          } else {
            Get.snackbar(
              "Unsuccessful",
              " please enter name",
              backgroundColor: Colors.red.withOpacity(0.8),
              duration: Duration(seconds: 4),
            );
          }
        },
        editFunc: () {
          String oldName = tools.category;
          var music = Get.find<MusicControllers>();

          if (_txt.length != 0) {
            int selectedIndex = tools.categories.indexOf(tools.category);
            tools.edit(selectedIndex, _txt);
            List<Music> musics = music.get((m) => m.musicCategory == oldName);
            for (var item in musics) {
              item.musicCategory = _txt;
              music.edit(item);
            }
            _txt = "";
            Get.snackbar(
              "Successful",
              "Category $_txt edited successfully",
              backgroundColor: Colors.green.withOpacity(0.8),
            );
          } else {
            Get.snackbar(
              "Unsuccessful",
              " please enter name",
              backgroundColor: Colors.red.withOpacity(0.8),
              duration: Duration(seconds: 4),
            );
          }
        },
        deleteFunc: () {
          var music = Get.find<MusicControllers>();
          if (_txt.length != 0) {
            int selectedIndex = tools.categories.indexOf(tools.category);
            tools.delete(selectedIndex);
            List<Music> musics = music.get((m) => m.musicCategory == _txt);
            for (var item in musics) {
              music.delete(item);
            }

            _txt = "";
            Get.snackbar(
              "Successful",
              "Category $_txt delete successfully",
              backgroundColor: Colors.green.withOpacity(0.8),
            );
          } else {
            Get.snackbar(
              "Unsuccessful",
              " please enter name",
              backgroundColor: Colors.red.withOpacity(0.8),
              duration: Duration(seconds: 4),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<ToolController>(
          init: ToolController(),
          initState: (_) {},
          builder: (ctrl) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TabBarMusic(
                  func: () {
                    _txt = ctrl.category;
                    ctrl.update();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 50, right: 50),
                  child: TextField(
                    controller: TextEditingController(text: _txt),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: "Input your category name",
                    ),
                    onChanged: (value) {
                      _txt = value;
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget CrudButtons({
    String label = "",
    IconData icon = Icons.photo,
    Function()? func,
    Color color = Colors.white,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: ElevatedButton.icon(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all<Color>(color),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
        label: Text(label),
        onPressed: func,
        icon: Icon(icon),
      ),
    );
  }
}
