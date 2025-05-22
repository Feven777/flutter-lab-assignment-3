import '../models/album.dart';
import '../models/photo.dart';
import '../../utils/api_service.dart';

class AlbumRepository {
  final ApiService apiService = ApiService();

  Future<List<Album>> getAlbums() => apiService.fetchAlbums();
  Future<List<Photo>> getPhotos() => apiService.fetchPhotos();
}