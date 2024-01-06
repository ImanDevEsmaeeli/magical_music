import 'package:hive/hive.dart';
import 'package:magical_music/database/models/toolDbModel.dart';

class ToolsDB {
  static String boxName = "toolsBox";
  ToolDbModel _db = ToolDbModel();
  Box<ToolDbModel>? _box;

  ToolsDB() {
    _box = Hive.box<ToolDbModel>(boxName);
    if (_box!.isEmpty) {
      _db.id = "empty1234";
      _db.index = 0;
      _db.musicCategory = "empty";
      _box?.add(_db);
    }
  }
  String? getPathDirectory() {
    return _box?.path;
  }

  Box<ToolDbModel>? getDatabaseBox() {
    return _box;
  }

  void add(String category, String id) {
    _db.musicCategory = category;
    _db.id = id;
    _db.index = _box!.length;
    _box!.add(_db);
  }

  void setCategory(int index) {
    List<ToolDbModel> tools = _box!.values.toList();
    for (var tool in tools) {
      ToolDbModel _dbEdit = ToolDbModel();
      _dbEdit.musicCategory = tool.musicCategory;
      _dbEdit.index = index;
      _box?.putAt(tools.indexOf(tool), _dbEdit);
    }
  }

  List<String> getCategories() {
    return _box!.values.map((e) => e.musicCategory).toList();
  }

  String getCategory() {
    if (_box!.isEmpty) {
      return "";
    } else {
      int index = _box!.values.first.index;

      var s = _box!.values.toList()[index].musicCategory;
      return s;
    }
  }

  void delete(int index) {
    _box!.deleteAt(index);
  }

  void update(int index, String newCategory) {
    ToolDbModel item = _box!.values.toList()[index];
    int key = _box!.keys.toList()[index];
    item.musicCategory = newCategory;
    _box!.putAt(index, item);
  }
}
