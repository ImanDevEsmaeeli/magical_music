import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:magical_music/database/models/toolDbModel.dart';
import 'package:magical_music/database/services/toolDB.dart';
import 'package:magical_music/tools/enums/bottomNavigationMode.dart';
import 'package:magical_music/tools/enums/crudMode.dart';
import 'package:uuid/uuid.dart';

class ToolController extends GetxController {
  ToolsDB _db = ToolsDB();

  String _category = "";
  String get category {
    _category = _db.getCategory();
    return _category;
  }

  void setCategory(int category) {
    _db.setCategory(category);

    update();
  }

  // List<String> _categories = [];
  List<String> get categories {
    return getCategories();
  }

  void add(String tool) {
    ToolsDB dbAdd = ToolsDB();
    dbAdd.add(tool, Uuid().v1());
    update();
  }

  List<String> getCategories() {
    return _db.getCategories();
  }

  void delete(int index) {
    _db.delete(index);
    update();
  }

  void edit(int index, String newCategory) {
    _db.update(index, newCategory);
    update();
  }

  bool _isEditable = false;
  bool get isEditable {
    return _isEditable;
  }

  void editable(bool editable) {
    _isEditable = editable;
    update();
  }

  bool _checkBoxVisiblity = false;
  bool get checkBoxVisiblity {
    return _checkBoxVisiblity;
  }

  void checkBoxVisible(bool isvisible) {
    _checkBoxVisiblity = isvisible;
    update();
  }

  BottomNavigationMode _navigationMode = BottomNavigationMode.home;
  BottomNavigationMode get navigationMode {
    return _navigationMode;
  }

  void setnavigationMode(BottomNavigationMode mode) {
    _navigationMode = mode;
    update();
  }

  CrudMode _crudMode = CrudMode.add;
  CrudMode get crudMode {
    return _crudMode;
  }

  void setcrudeMode(CrudMode mode) {
    _crudMode = mode;
    update();
  }

  bool _playerVisibility = false;
  bool get playerVisibility {
    return _playerVisibility;
  }

  void playerVisible(bool visible) {
    _playerVisibility = visible;
    update();
  }

  String getPath() {
    return _db.getPathDirectory().toString();
  }

  Future<void> createBackup() async {
    Map<String, ToolDbModel> map = _db
        .getDatabaseBox()!
        .toMap()
        .map((key, value) => MapEntry(key.toString(), value));
    String json = jsonEncode(map);

    Directory backUpDir = await _getSaveDirectory();

    String formattedDate = DateTime.now()
        .toString()
        .replaceAll('.', '-')
        .replaceAll(' ', '-')
        .replaceAll(':', '-');
    String path = '${backUpDir.path}$formattedDate.toolsbackup';
    File backupFile = File(path);
    await backupFile.writeAsString(json);
  }

  Future<Directory> _getSaveDirectory() async {
    String? folderPath = await FilePicker.platform.getDirectoryPath();
    return Directory(folderPath.toString() + "/");
  }
}
