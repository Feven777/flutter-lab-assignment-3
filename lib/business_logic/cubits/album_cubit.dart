import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/album.dart';
import '../../data/repositories/album_repository.dart';

abstract class AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  AlbumLoaded(this.albums);
}

class AlbumError extends AlbumState {
  final String message;
  AlbumError(this.message);
}

class AlbumCubit extends Cubit<AlbumState> {
  final AlbumRepository albumRepository;

  AlbumCubit(this.albumRepository) : super(AlbumLoading());

  void fetchAlbums() async {
    try {
      final albums = await albumRepository.getAlbums();
      emit(AlbumLoaded(albums));
    } catch (e) {
      emit(AlbumError("Failed to load albums. Please check your network."));
    }
  }
}