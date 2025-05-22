import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/photo.dart';
import '../../data/repositories/album_repository.dart';

class AlbumDetailScreen extends StatefulWidget {
  final int albumId;

  const AlbumDetailScreen({super.key, required this.albumId});

  @override
  AlbumDetailScreenState createState() => AlbumDetailScreenState();
}

class AlbumDetailScreenState extends State<AlbumDetailScreen> {
  late Future<List<Photo>> photos;

  @override
  void initState() {
    super.initState();
    photos = AlbumRepository().getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text("Album Details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
  backgroundColor: Colors.blueAccent,
  elevation: 4,
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      context.go('/'); // Navigates back to AlbumListScreen
    },
  ),
),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Album ID: ${widget.albumId}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
              "Details about this album will be displayed here.",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Photo>>(
                future: photos,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Failed to load photos", style: TextStyle(color: Colors.red, fontSize: 18)),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                photos = AlbumRepository().getPhotos();
                              });
                            },
                            child: Text("Retry"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    final albumPhotos = snapshot.data!
                        .where((photo) => photo.albumId == widget.albumId)
                        .toList();
                    return ListView.builder(
                      itemCount: albumPhotos.length,
                      itemBuilder: (context, index) {
                        final photo = albumPhotos[index];
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            title: Text(photo.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                            leading: Icon(Icons.image, color: Colors.blueAccent, size: 40),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}