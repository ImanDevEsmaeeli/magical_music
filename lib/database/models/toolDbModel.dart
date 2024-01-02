import 'package:hive/hive.dart';

part 'toolDbModel.g.dart';

@HiveType(typeId: 2)
class ToolDbModel {
  @HiveField(0)
  String musicCategory = "";
  @HiveField(1)
  int index = 0;
  @HiveField(2)
  String id = "";

  ToolDbModel();

  ToolDbModel.fromJson(Map<String, dynamic> objectjson) {
    musicCategory = objectjson["musicCategory"];
    index = objectjson["index"];
    id = objectjson["id"];
  }

  Map<String, dynamic> toJson() => {
        "musicCategory": musicCategory,
        "index": index,
        "id": id,
      };
}
