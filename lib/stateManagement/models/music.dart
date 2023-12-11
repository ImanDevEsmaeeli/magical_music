class Music {
  String id;
  String name;
  String description;
  String musicAddress;
  String textAddress;
  bool isFavorite;
  String musicCategory;

  Music({
    required this.id,
    required this.name,
    this.description = "description",
    required this.musicAddress,
    this.textAddress = "",
    this.isFavorite = false,
    required this.musicCategory,
  });
}
