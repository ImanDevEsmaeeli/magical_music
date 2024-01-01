import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:magical_music/database/models/musicDbModel.dart';
import 'package:magical_music/database/services/musicDB.dart';
import 'package:magical_music/stateManagement/bindings/musicIds.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';
import 'package:magical_music/tools/music_converters.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/music.dart';
import 'favoriteMusicController.dart';
import 'selectionMusicControllers.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicControllers extends SelectionMusicControllers {
  MusicDB _db = MusicDB();
  String category = "";

  MusicControllers() {
    refreshItems();
  }

  final RxList<Music> _items = RxList();
  List<Music> get items {
    //refreshItems();
    return [..._items];
  }

  set items(List<Music> musics) {
    _items.clear();
    _items.addAll(musics);
    update([MusicIds.musicList]);
  }

  void refreshItems() {
    category = Get.find<ToolController>().category;
    items = get((m) => m.musicCategory == category);
  }

  List<Music> get([bool Function(Music)? func]) {
    if (func == null) {
      return _db.get();
    } else {
      return _db.get().where(func).toList();
    }
  }

  Music getById(String id) {
    return get((m) => m.id == id)[0];
  }

  void add(Music music) {
    MusicDB addDB = MusicDB();
    addDB.add(music);
    _items.add(music);
    //_items.refresh();
    update();
  }

  void delete(Music music) {
    _db.delete(music);
    _items.remove(music);
    update();
  }

  void edit(Music music) {
    _db.update(music);
    _items[_items.indexWhere((m) => m.id == music.id)] = music;
    update();
  }

  void favorite(Music music) {
    music.isFavorite = (!music.isFavorite);
    _db.update(music);
    _items[_items.indexWhere((m) => m.id == music.id)] = music;
    update([MusicIds.favorite]);
  }

  void showFavorite() {
    items = get((m) => m.isFavorite == true);
    update();
  }

  String _searchTxt = "";
  String get searchTxt => _searchTxt;
  set searchTxt(String txt) {
    _searchTxt = txt;
    items = get(
      (m) =>
          (m.musicCategory == category) &&
          (m.name.toLowerCase().contains(txt.toLowerCase())),
    );
    update();
  }

  //=================================================================

  String getPath() {
    return _db.getPathDirectory().toString();
  }

  Future<void> createBackup() async {
    // if (favoriteBooksBox.isEmpty) {
    //   _scaffoldKey.currentState.showSnackBar(
    //     SnackBar(content: Text('Pick a favorite book.')),
    //   );
    //   return;
    // }
    // _scaffoldKey.currentState.showSnackBar(
    //   SnackBar(content: Text('Creating backup...')),
    // );
    Map<String, MusicDbModel> map = _db
        .getDatabaseBox()!
        .toMap()
        .map((key, value) => MapEntry(key.toString(), value));
    String json = jsonEncode(map);

    Directory dir = await _getDirectory();

    if (await dir.exists()) {
      // dir = Directory(dir.path + "/");
      String formattedDate = DateTime.now()
          .toString()
          .replaceAll('.', '-')
          .replaceAll(' ', '-')
          .replaceAll(':', '-');
      String path = '${dir.path}$formattedDate.hivebackup';
      File backupFile = File(path);
      await backupFile.writeAsString(json);
    }
  }

  Future<Directory> _getDirectory() async {
    Directory? directory = await getExternalStorageDirectory();
    const String pathExt = '/backups/';
    Directory newDirectory = Directory(directory!.path + pathExt);
    if (await newDirectory.exists() == false) {
      return newDirectory.create(recursive: true);
    }
    return newDirectory;
  }

  // Future<Directory> _getDirectory() async {
  //   String? folderPath = await FilePicker.platform.getDirectoryPath();
  //   return Directory(folderPath.toString());
  // }
}
