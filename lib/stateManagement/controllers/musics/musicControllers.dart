import 'package:get/get.dart';
import 'package:magical_music/database/services/musicDB.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';
import '../../models/music.dart';
import 'favoriteMusicController.dart';
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
    update();
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
    edit(music);
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

  String getPath() {
    return _db.getPathDirectory().toString();
  }
}
