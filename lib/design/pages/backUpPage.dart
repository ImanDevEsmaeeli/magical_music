import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:magical_music/stateManagement/controllers/musics/musicControllers.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';

class BackUpPage extends StatelessWidget {
  BackUpPage({super.key});
  String? folderPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bach up"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton.icon(
              label: Text("Export"),
              style: ButtonStyle(
                shadowColor:
                    MaterialStateProperty.all<Color>(Colors.blue.shade200),
                side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(width: 2, color: Colors.blue.shade300)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  StadiumBorder(),
                ),
              ),
              onPressed: () async {
                await Get.find<MusicControllers>().createBackup();
                await Get.find<ToolController>().createBackup();

                // folderPath = await FilePicker.platform.getDirectoryPath();
                // List<String> dataBasePath = [];
                // dataBasePath.add(Get.find<MusicControllers>().getPath());
                // dataBasePath.add(Get.find<ToolController>().getPath());

                // for (var element in dataBasePath) {
                //   await io.File(element).copy(folderPath.toString());
                // }

                // await File(Get.find<MusicControllers>().items[0].musicAddress)
                //     .copy(folderPath.toString());
              },
              icon: SvgPicture.asset("assets/icons/database_export.svg"),
            ),
            OutlinedButton.icon(
              label: Text("import"),
              style: ButtonStyle(
                shadowColor:
                    MaterialStateProperty.all<Color>(Colors.blue.shade200),
                side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(width: 2, color: Colors.blue.shade300)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  StadiumBorder(),
                ),
              ),
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/database_import.svg"),
            ),
          ],
        ),
      ),
    );
  }
}
