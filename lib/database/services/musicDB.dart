import 'package:hive/hive.dart';
import 'package:magical_music/database/models/musicDbModel.dart';
import 'package:magical_music/stateManagement/models/music.dart';

class MusicDB {
  static String boxname = "musicBox";
  MusicDbModel _db = MusicDbModel();
  Box<MusicDbModel>? _box;

  MusicDB() {
    _box = Hive.box<MusicDbModel>(boxname);
  }

  String? getPathDirectory() {
    return _box!.path;
  }

  Box<MusicDbModel>? getDatabaseBox() {
    return _box;
  }

  Music _convertToMusic(MusicDbModel musicDbModel) {
    return Music(
      id: musicDbModel.id,
      name: musicDbModel.name,
      musicAddress: musicDbModel.musicAddress,
      musicCategory: musicDbModel.musicCategory,
      description: musicDbModel.description,
      isFavorite: musicDbModel.isFavorite,
      textAddress: musicDbModel.textAddress,
    );
  }

  void add(Music music) {
    _db.id = music.id;
    _db.name = music.name;
    _db.description = music.description;
    _db.musicAddress = music.musicAddress;
    _db.textAddress = music.textAddress;
    _db.isFavorite = music.isFavorite;
    _db.musicCategory = music.musicCategory;
    _box!.add(_db);
  }

  void delete(Music music) async {
    int index = _box!.values.toList().indexWhere((m) => m.id == music.id);
    await _box!.deleteAt(index);
  }

  void update(Music music) {
    int indx = _box!.values.toList().indexWhere((m) => m.id == music.id);
    MusicDbModel newMusic = MusicDbModel();

    newMusic.id = music.id;
    newMusic.name = music.name;
    newMusic.description = music.description;
    newMusic.musicAddress = music.musicAddress;
    newMusic.textAddress = music.textAddress;
    newMusic.isFavorite = music.isFavorite;
    newMusic.musicCategory = music.musicCategory;

    _box?.putAt(indx, newMusic);
  }

  List<Music> get() {
    List<Music> items = [];
    for (var element in _box!.values) {
      items.add(_convertToMusic(element));
    }

    return items;
  }
}
