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
}
