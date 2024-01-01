import 'package:get/get.dart';

import '../../models/music.dart';

class SelectionMusicControllers extends GetxController {
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
}
