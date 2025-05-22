import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/models/album.dart';
import '../data/models/photo.dart';

class ApiService {
  static const String albumUrl = 'https://jsonplaceholder.typicode.com/albums';
  static const String photoUrl = 'https://jsonplaceholder.typicode.com/photos';

  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(Uri.parse(albumUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((album) => Album.fromJson(album)).toList();
    } else {
      throw Exception("Failed to load albums");
    }
  }

  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(Uri.parse(photoUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((photo) => Photo.fromJson(photo)).toList();
    } else {
      throw Exception("Failed to load photos");
    }
  }
}