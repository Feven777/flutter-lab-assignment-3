class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;

  Photo({required this.albumId, required this.id, required this.title, required this.url});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
    );
  }
}