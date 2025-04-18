enum MediaType {
  image,
  video;

  bool get isVideo => this == MediaType.video;

  static MediaType typeFromJson(String? type) {
    return MediaType.values.firstWhere(
      (element) => element.name == type,
      orElse: () => MediaType.image,
    );
  }
}
