import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';
import 'package:magical_music/tools/enums/crudMode.dart';
import 'package:magical_music/widgets/addView.dart';

class OnLongPressView extends StatelessWidget {
  const OnLongPressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        margin: EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 7,
            children: [
              OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(width: 1, color: Colors.blue),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      const StadiumBorder(
                        side: BorderSide(),
                      ),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AddView(mode: CrudMode.edit);
                      },
                    );
                    Get.close(1);
                  },
                  child: const Text("edit")),
              OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(width: 1, color: Colors.blue),
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    const StadiumBorder(
                      side: BorderSide(),
                    ),
                  ),
                ),
                onPressed: () {
                  Get.find<ToolController>().checkBoxVisible(true);
                  Get.find<ToolController>().setcrudeMode(CrudMode.delete);
                  Get.close(1);
                },
                child: const Text("multi delete"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
