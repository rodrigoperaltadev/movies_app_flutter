import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/routes/routes.dart';

class MovieSlider extends StatelessWidget {
  final List<Movie> movies;
  final String title;
  final Function? onEndScroll;

  const MovieSlider(
      {Key? key, required this.movies, required this.title, this.onEndScroll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MovieSliderTitle(
            title: title,
          ),
          const SizedBox(height: 10),
          _MoviesList(movies: movies, onEndScroll: onEndScroll),
        ],
      ),
    );
  }
}

class _MovieSliderTitle extends StatelessWidget {
  final String title;
  const _MovieSliderTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _MoviesList extends StatefulWidget {
  final List<Movie> movies;
  final Function? onEndScroll;

  const _MoviesList({
    Key? key,
    required this.movies,
    this.onEndScroll,
  }) : super(key: key);

  @override
  State<_MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<_MoviesList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        if (widget.onEndScroll != null) {
          widget.onEndScroll!();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              return _MoviePoster(movie: movie);
            }));
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.details,
                arguments: movie),
            child: Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                  width: 130,
                  height: 190,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
