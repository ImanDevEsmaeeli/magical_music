import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:magical_music/stateManagement/controllers/musicControllers.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';
import 'package:magical_music/stateManagement/models/music.dart';
import 'package:magical_music/tools/enums/crudMode.dart';
import 'package:uuid/uuid.dart';

class AddView extends StatelessWidget {
  // const AddView({super.key});
  final CrudMode mode;
  Music musicItem = Music(
    id: "",
    name: "",
    musicAddress: "",
    musicCategory: "",
  );

  AddView({required this.mode}) {
    if (mode == CrudMode.add) {
      musicItem = Music(
        id: "",
        name: "",
        musicAddress: "",
        musicCategory: "",
      );
    } else if (mode == CrudMode.edit) {
      musicItem = Get.find<MusicControllers>().selectedMusic;
      if (musicItem.musicAddress.isNotEmpty) {}
    }
  }

  late bool _isMusicfileSelected = false;

  late bool _isPdffileSelected = false;

  FilePickerResult? musicResult;

  FilePickerResult? pdfResult;

  late TextEditingController nametxt = TextEditingController();

  late TextEditingController descriptiontxt = TextEditingController();

  // @override
  @override
  Widget build(BuildContext context) {
    final _tools = Get.find<ToolController>();
    final _music = Get.find<MusicControllers>();
    final _musics = _music.items;

    return AlertDialog(
      contentPadding: EdgeInsets.all(1),
      backgroundColor: Colors.blue[50],
      scrollable: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(7),
          bottomLeft: Radius.elliptical(90, 110),
          bottomRight: Radius.circular(7),
          topRight: Radius.elliptical(90, 110),
        ),
        side: BorderSide(width: 2, color: Colors.blue),
      ),
      content: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(7),
              bottomLeft: Radius.elliptical(90, 110),
              bottomRight: Radius.circular(7),
              topRight: Radius.elliptical(90, 110),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade500,
                Colors.blue.shade200,
                Colors.green.shade200,
                Colors.green.shade500,
              ],
            ),
          ),
          child: GetBuilder<MusicControllers>(
            builder: (musicController) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: Text("${mode.name} ${_tools.category}"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    padding: const EdgeInsets.all(7),
                    label: const Text("select music file"),
                    deleteButtonTooltipMessage: "music file",
                    avatar: _isMusicfileSelected
                        ? const Icon(
                            Icons.check_circle_outline_outlined,
                            color: Colors.green,
                          )
                        : const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                    onDeleted: () async {
                      musicResult = await FilePicker.platform.pickFiles(
                        dialogTitle: "select music file",
                        type: FileType.audio,
                      );
                      if (musicResult != null) {
                        if (musicResult!.names[0]!.isNotEmpty) {
                          musicItem.musicAddress =
                              musicResult!.paths[0].toString();
                          //setState(() {
                          _isMusicfileSelected = true;
                          // });
                          nametxt.text = musicResult!.names[0].toString();
                        }
                      }
                    },
                    deleteIcon: SvgPicture.asset(
                      "assets/icons/musicFile.svg",
                      colorFilter: const ColorFilter.srgbToLinearGamma(),
                    ),
                    labelPadding: const EdgeInsets.all(8),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    padding: const EdgeInsets.all(7),
                    label: const Text("select pdf file"),
                    deleteButtonTooltipMessage: "pdf file",
                    avatar: _isPdffileSelected
                        ? const Icon(
                            Icons.check_circle_outline_outlined,
                            color: Colors.green,
                          )
                        : const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                    onDeleted: () async {
                      pdfResult = await FilePicker.platform.pickFiles(
                        dialogTitle: "select pdf file",
                        type: FileType.any,
                      );
                      if (pdfResult != null) {
                        if (pdfResult!.names[0]!.isNotEmpty) {
                          musicItem.textAddress =
                              pdfResult!.paths[0].toString();
                          // setState(() {
                          _isPdffileSelected = true;
                          // });
                        }
                      }
                    },
                    deleteIcon: SvgPicture.asset(
                      "assets/icons/pdfFile.svg",
                      colorFilter: const ColorFilter.srgbToLinearGamma(),
                    ),
                    labelPadding: const EdgeInsets.all(8),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: TextField(
                    controller: nametxt,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Name',
                      icon: SvgPicture.asset(
                        "assets/icons/musicName.svg",
                        colorFilter: const ColorFilter.srgbToLinearGamma(),
                        height: 35,
                      ),
                    ),
                    onChanged: ((name) {
                      musicItem.name = name;
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: TextField(
                    controller: descriptiontxt,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Description',
                      icon: SvgPicture.asset(
                        "assets/icons/musicDescription.svg",
                        colorFilter: const ColorFilter.srgbToLinearGamma(),
                        height: 35,
                      ),
                    ),
                    onChanged: (desc) {
                      musicItem.description = desc;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        backgroundColor: Colors.blue[100],
                        foregroundColor: Colors.blue[900],
                        shape: const StadiumBorder(),
                        side: BorderSide(
                          width: 2,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      onPressed: (_isMusicfileSelected)
                          ? () {
                              switch (mode) {
                                case CrudMode.add:
                                  musicItem.musicCategory = _tools.category;
                                  musicItem.id = Uuid().v1();
                                  _music.add(musicItem);
                                  break;
                                case CrudMode.edit:
                                  _music.edit(musicItem);
                                  break;
                                default:
                              }
                            }
                          : null,
                      label: (() {
                        switch (mode) {
                          case CrudMode.edit:
                            return const Text("Edit");

                          default:
                            return const Text("Save");
                        }
                      }()),
                      icon: (_isMusicfileSelected)
                          ? const Icon(
                              Icons.check_circle_outline_outlined,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
