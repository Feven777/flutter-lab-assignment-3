
import 'package:go_router/go_router.dart';
import 'presentation/screens/album_list_screen.dart';
import 'presentation/screens/album_detail_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => AlbumListScreen(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) => AlbumDetailScreen(albumId: int.parse(state.pathParameters['id']!)),
    ),
  ],
);