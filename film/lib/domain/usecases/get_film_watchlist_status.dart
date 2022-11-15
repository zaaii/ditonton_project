import 'package:film/domain/repositories/film_repository.dart';

class GetWatchListStatusFilm {
  final FilmRepository filmRepository;

  GetWatchListStatusFilm(this.filmRepository);

  Future<bool> execute(int id) async {
    return filmRepository.isFilmAddedToWatchlist(id);
  }
}
