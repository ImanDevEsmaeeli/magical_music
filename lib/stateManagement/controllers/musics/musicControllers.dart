import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:magical_music/database/models/musicDbModel.dart';
import 'package:magical_music/database/services/musicDB.dart';
import 'package:magical_music/stateManagement/bindings/musicIds.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';
import '../../models/music.dart';
import 'selectionMusicControllers.dart';

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
    update([MusicIds.musicList]);
  }

  void delete(Music music) {
    _db.delete(music);
    _items.remove(music);
    update([MusicIds.musicList]);
  }

  void edit(Music music) {
    _db.update(music);
    _items[_items.indexWhere((m) => m.id == music.id)] = music;
    update([MusicIds.musicList]);
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
    Map<String, MusicDbModel> map = _db
        .getDatabaseBox()!
        .toMap()
        .map((key, value) => MapEntry(key.toString(), value));
    String json = jsonEncode(map);

    Directory backUpDir = await _getSaveDirectory();

    // dir = Directory(dir.path + "/");
    String formattedDate = DateTime.now()
        .toString()
        .replaceAll('.', '-')
        .replaceAll(' ', '-')
        .replaceAll(':', '-');
    String path = '${backUpDir.path}$formattedDate.musicbackup';
    File backupFile = File(path);
    await backupFile.writeAsString(json);
  }

  // Future<Directory> _getDirectory() async {
  //   Directory? directory = await pathPro.getExternalStorageDirectory();
  //   const String pathExt = '/backups/';
  //   Directory newDirectory = Directory(directory!.path + pathExt);
  //   if (await newDirectory.exists() == false) {
  //     return newDirectory.create(recursive: true);
  //   }
  //   return newDirectory;
  // }

  Future<Directory> _getSaveDirectory() async {
    String? folderPath = await FilePicker.platform.getDirectoryPath();
    return Directory(folderPath.toString() + "/");
  }

  Future<void> restoreBackup() async {
    FilePickerResult? results = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );
    if (results == null) return;

    var ss = results.files[0].extension;

    PlatformFile? music = results.files
        .firstWhereOrNull((file) => file.extension == "musicbackup");
    if (music == null) return;

    File musicFile = File(music.path.toString());

    Map<String, dynamic> map =
        jsonDecode(await musicFile.readAsString()) as Map<String, dynamic>;
    var mmap = map.map<int, MusicDbModel>(
        (key, value) => MapEntry(int.parse(key), MusicDbModel.fromJson(value)));

    await _db.getDatabaseBox()!.clear();
    _db.getDatabaseBox()!.putAll(mmap);
  }
}
