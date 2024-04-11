import 'package:fun/iterable.dart';
import 'package:test/test.dart';

void main() {
  test('alphabetical', () {
    final list = ['c', 'a', 'b'];
    expect(list.alphabetical((item) => item), equals(['a', 'b', 'c']));
    expect(
        list.alphabetical((item) => item, desc: true), equals(['c', 'b', 'a']));
  });

  test('cluster', () {
    final data = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    final clusters = data.cluster(3);
    final expected = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
    ];
    expect(clusters, equals(expected));
  });
}
