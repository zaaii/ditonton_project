import 'package:serialtv/domain/entities/serialtv_genre.dart';
import 'package:serialtv/data/models/serialtv_table.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/entities/serialtv_detail.dart';

final testSerialTv = SerialTv(
    backdropPath: "/path.jpg",
    genreIds: [1, 2],
    id: 1,
    originalName: "Title",
    overview: "Title",
    popularity: 1.0,
    posterPath: "/path.jpg",
    firstAirDate: "2022-08-22",
    name: "Title",
    voteAverage: 1.0,
    voteCount: 1
);

final testSerialTvList = [testSerialTv];

final testDetailSerialTv = DetailSerialTv(
    backdropPath: "/maFEWU41jdUOzDfRVkojq7fluIm.jpg",
    genres: [ SerialTvGenre(id: 16, name: "Animation"), SerialTvGenre(id: 35, name: "Comedy"),
      SerialTvGenre(id: 10751, name: "Family"), SerialTvGenre(id: 10765, name: "Sci-Fi & Fantasy")
    ],
    id: 387,
    firstAirDate: "1999-05-01",
    numberOfSeasons: 13,
    numberOfEpisodes: 537,
    overview:
    "Deep down in the Pacific Ocean in the subterranean city of Bikini Bottom lives a square yellow sponge named SpongeBob SquarePants. SpongeBob lives in a pineapple with his pet snail, Gary, loves his job as a fry cook at the Krusty Krab, and has a knack for getting into all kinds of trouble without really trying. When he's not getting on the nerves of his cranky next door neighbor Squidward, SpongeBob can usually be found smack in the middle of all sorts of strange situations with his best buddy, the simple yet lovable starfish, Patrick, or his thrill-seeking surfer-girl squirrel pal, Sandy Cheeks.",
    posterPath: "/amvtZgiTty0GHIgD56gpouBWrcy.jpg",
    name: "SpongeBob SquarePants",
    voteAverage: 7.576,
    voteCount: 2525
);

final testWatchListSerialTv = SerialTv.watchlist(
    id: 387,
    overview: "Deep down in the Pacific Ocean in the subterranean city of Bikini Bottom lives a square yellow sponge named SpongeBob SquarePants. SpongeBob lives in a pineapple with his pet snail, Gary, loves his job as a fry cook at the Krusty Krab, and has a knack for getting into all kinds of trouble without really trying. When he's not getting on the nerves of his cranky next door neighbor Squidward, SpongeBob can usually be found smack in the middle of all sorts of strange situations with his best buddy, the simple yet lovable starfish, Patrick, or his thrill-seeking surfer-girl squirrel pal, Sandy Cheeks.",
    posterPath: "/amvtZgiTty0GHIgD56gpouBWrcy.jpg",
    name: "SpongeBob SquarePants"
);

final testSerialTvTable = SerialTvTable(
    id: 387,
    name: "SpongeBob SquarePants",
    posterPath: "/amvtZgiTty0GHIgD56gpouBWrcy.jpg",
    overview: "Deep down in the Pacific Ocean in the subterranean city of Bikini Bottom lives a square yellow sponge named SpongeBob SquarePants. SpongeBob lives in a pineapple with his pet snail, Gary, loves his job as a fry cook at the Krusty Krab, and has a knack for getting into all kinds of trouble without really trying. When he's not getting on the nerves of his cranky next door neighbor Squidward, SpongeBob can usually be found smack in the middle of all sorts of strange situations with his best buddy, the simple yet lovable starfish, Patrick, or his thrill-seeking surfer-girl squirrel pal, Sandy Cheeks."
);

final testSerialTvMap = {
  'id': 387,
  'overview': "Deep down in the Pacific Ocean in the subterranean city of Bikini Bottom lives a square yellow sponge named SpongeBob SquarePants. SpongeBob lives in a pineapple with his pet snail, Gary, loves his job as a fry cook at the Krusty Krab, and has a knack for getting into all kinds of trouble without really trying. When he's not getting on the nerves of his cranky next door neighbor Squidward, SpongeBob can usually be found smack in the middle of all sorts of strange situations with his best buddy, the simple yet lovable starfish, Patrick, or his thrill-seeking surfer-girl squirrel pal, Sandy Cheeks.",
  'posterPath': "/amvtZgiTty0GHIgD56gpouBWrcy.jpg",
  'name': "SpongeBob SquarePants"
};
