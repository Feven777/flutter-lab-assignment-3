import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubits/album_cubit.dart';
import '../../data/repositories/album_repository.dart';
import 'package:go_router/go_router.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumCubit(AlbumRepository())..fetchAlbums(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Albums", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.blueAccent,
          elevation: 4,
        ),
        body: BlocBuilder<AlbumCubit, AlbumState>(
          builder: (context, state) {
            if (state is AlbumLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AlbumError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message, style: TextStyle(color: Colors.red, fontSize: 18)),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AlbumCubit>().fetchAlbums();
                      },
                      child: Text("Retry"),
                    )
                  ],
                ),
              );
            } else if (state is AlbumLoaded) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: state.albums.length,
                  itemBuilder: (context, index) {
                    final album = state.albums[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        title: Text(album.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                        leading: Icon(Icons.photo_album, color: Colors.blueAccent, size: 40), 
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                        onTap: () {
                          context.go('/details/${album.id}');
                        },
                      ),
                    );
                  },
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}