import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'musicDbModel.g.dart';

@HiveType(typeId: 1)
class MusicDbModel extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String description;
  @HiveField(3)
  late String musicAddress;
  @HiveField(4)
  late String textAddress;
  @HiveField(5)
  late bool isFavorite;
  @HiveField(6)
  late String musicCategory;

  MusicDbModel();

  MusicDbModel.fromJson(Map<String, dynamic> objectjson)
      : description = objectjson["description"],
        id = objectjson["id"],
        name = objectjson["name"],
        musicAddress = objectjson["musicAddress"],
        textAddress = objectjson["textAddress"],
        isFavorite = objectjson["isFavorite"],
        musicCategory = objectjson["musicCategory"];

  Map<String, dynamic> toJson() => {
        "description": description,
        "id": id,
        "name": name,
        "musicAddress": musicAddress,
        "textAddress": textAddress,
        "isFavorite": isFavorite,
        "musicCategory": musicCategory
      };
}
