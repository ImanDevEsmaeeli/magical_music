import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';

class SettingPage extends StatefulWidget {
  List<String> labels = [];
  ToolController tools = ToolController();
  SettingPage() {
    tools = Get.find<ToolController>();
    labels = tools.getCategories();
  }

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _txt = "";

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    //final tools = Provider.of<Tools>(context);

    return Scaffold(
      appBar: AppBar(title: Text("setting")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder<ToolController>(
              builder: (ctrl) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 7,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    ctrl.categories.length,
                    (index) => ChoiceChip(
                      label: Text(ctrl.categories[index]),
                      labelPadding: EdgeInsets.all(7),
                      labelStyle: TextStyle(
                        fontSize: (selectedIndex == index) ? 18 : 16,
                        color: (selectedIndex == index)
                            ? Colors.white
                            : Colors.blue,
                      ),
                      selected: selectedIndex == index,
                      selectedColor: Colors.blue,
                      backgroundColor: Colors.blue.shade50,
                      side: BorderSide(color: Colors.blue, width: 1),
                      onSelected: (value) {
                        setState(() {
                          selectedIndex = value ? index : selectedIndex;
                        });
                        _txt = ctrl.categories[selectedIndex];
                      },
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
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
                    ),
                  ),

                  CrudButtons(
                    color: Colors.green,
                    icon: Icons.add,
                    label: "add",
                    func: (() {
                      if (_txt.length != 0) {
                        widget.tools.add(_txt);
                      }
                    }),
                  ),

                  CrudButtons(
                    color: Colors.yellow,
                    icon: Icons.edit,
                    label: "edit",
                    func: (() {
                      if (_txt.length != 0) {
                        widget.tools.edit(selectedIndex, _txt);
                      }
                    }),
                  ),
                  //
                  CrudButtons(
                    color: Colors.red,
                    icon: Icons.delete,
                    label: "delete",
                    func: (() {
                      if (_txt.length != 0) {
                        widget.tools.delete(selectedIndex);
                        _txt = "";
                      }
                    }),
                  ),
                ],
              ),
            )
          ],
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
