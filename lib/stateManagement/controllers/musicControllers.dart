import 'package:get/get.dart';
import 'package:magical_music/database/services/musicDB.dart';
import 'package:magical_music/stateManagement/controllers/toolControllers.dart';
import '../models/music.dart';

class MusicControllers extends GetxController {
  MusicDB _db = MusicDB();

  MusicControllers() {
    _items.addAll(get());
  }

  String _searchTxt = "";
  String get searchTxt => _searchTxt;
  set searchTxt(String txt) {}

  Music? _selectedMusic;
  Music get selectedMusic {
    if (_selectedMusic != null) {
      return _selectedMusic as Music;
    }
    return Music(
      id: "id",
      name: "name",
      musicAddress: "musicAddress",
      musicCategory: "musicCategory",
    );
  }

  void selectMusic(Music music) {
    _selectedMusic = music;
    update();
  }

  List<Music> _selectedMusics = [];
  List<Music> get selectedMusics {
    return _selectedMusics;
  }

  void addSelectedMusics(Music music) {
    _selectedMusics.add(music);
    update();
  }

  void removeSelectedMusics(Music music) {
    _selectedMusics.remove(music);
    update();
  }

  final RxList<Music> _items = RxList();
  List<Music> get items {
    refreshItems();
    return [..._items];
  }

  set items(List<Music> musics) {
    _items.clear();
    _items.addAll(musics);
    update();
  }

  void refreshItems() {
    var category = Get.find<ToolController>().category;
    items = get((m) => m.musicCategory == category);
  }

  List<Music> get([bool Function(Music)? func]) {
    if (func == null) {
      return _db.get();
    } else {
      return _db.get().where(func as bool Function(Music)).toList();
    }
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
}
