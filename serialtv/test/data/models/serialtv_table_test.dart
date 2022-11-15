import 'package:flutter_test/flutter_test.dart';
import '../../data_dummy/dummy_objects.dart';

void main() {
  final Map<String, dynamic> SerialTvTableJson = {
    'id': 387,
    'name': 'SpongeBob SquarePants',
    'posterPath': '/amvtZgiTty0GHIgD56gpouBWrcy.jpg',
    'overview': 'Deep down in the Pacific Ocean in the subterranean city of Bikini Bottom lives a square yellow sponge named SpongeBob SquarePants. SpongeBob lives in a pineapple with his pet snail, Gary, loves his job as a fry cook at the Krusty Krab, and has a knack for getting into all kinds of trouble without really trying. When he\'s not getting on the nerves of his cranky next door neighbor Squidward, SpongeBob can usually be found smack in the middle of all sorts of strange situations with his best buddy, the simple yet lovable starfish, Patrick, or his thrill-seeking surfer-girl squirrel pal, Sandy Cheeks.',
  };

  test('should return to Json tv table correctly', () {
    final result = testSerialTvTable.toJson();
    expect(result, SerialTvTableJson);
  });
}