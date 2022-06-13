import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/providers.dart';
import 'package:movies_app/routes/routes.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Buscar pelicula";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return getEmpty();

    final moviesProvider = Provider.of<MoviesProvider>(context);
    return FutureBuilder(
        future: moviesProvider.searchMovies(query),
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            final movies = snapshot.data!;
            if (movies.isEmpty) return getEmpty();
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (_, int index) => _MovieCard(movie: movies[index]),
            );
          } else {
            return getEmpty();
          }
        });
  }

  Widget getEmpty() {
    return const Center(
        child: Icon(
      Icons.movie_creation_outlined,
      color: Colors.grey,
      size: 90,
    ));
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;
  const _MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: const AssetImage('assets/no-image.jpg'),
        image: NetworkImage(movie.fullPosterImg),
        width: 50,
        height: 70,
        fit: BoxFit.cover,
      ),
      title: Text(movie.title),
      subtitle: Text(movie.releaseDate ?? '-'),
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.details, arguments: movie);
      },
    );
  }
}
