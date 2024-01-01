import 'package:magical_music/database/models/musicDbModel.dart';

class MusicConverters {
  static Map<String, dynamic> convertToJson(MusicDbModel musicDbModel) {
    return {
      "description": musicDbModel.description,
      "id": musicDbModel.id,
      "musicAddress": musicDbModel.musicAddress,
      "musicCategory": musicDbModel.musicCategory,
      "name": musicDbModel.name,
      "textAddress": musicDbModel.textAddress,
      "isFavorite": musicDbModel.isFavorite,
    };
  }
}
