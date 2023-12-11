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
}
