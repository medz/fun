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

  test('counting', () {
    final list = ['a', 'b', 'a', 'c', 'b', 'a'];
    final counts = list.counting((item) => item);
    final expected = {'a': 3, 'b': 2, 'c': 1};
    expect(counts, equals(expected));
  });

  test('diff', () {
    final list1 = [1, 2, 3, 4, 5];
    final list2 = [1, 2, 3, 4, 6];
    final diff = list1.diff(list2);
    expect(diff, equals([5]));
  });

  test('flat', () {
    final data = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
    ];
    final flattened = data.flat();
    final expected = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    expect(flattened, equals(expected));
  });

  test('partition', () {
    final list = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    condition(item) => item % 2 == 0;
    final result = list.partition(condition);
    final expected = ([2, 4, 6, 8], [1, 3, 5, 7, 9]);
    expect(result.$1, equals(expected.$1));
    expect(result.$2, equals(expected.$2));
  });

  test('group', () {
    final data = [
      (name: 'Alice', skill: 'Dart'),
      (name: 'Bob', skill: 'Dart'),
      (name: 'Charlie', skill: 'Flutter'),
    ];
    final grouped = data.group((item) => item.skill);
    final expected = {
      'Dart': [
        (name: 'Alice', skill: 'Dart'),
        (name: 'Bob', skill: 'Dart'),
      ],
      'Flutter': [
        (name: 'Charlie', skill: 'Flutter'),
      ],
    };
    expect(grouped, equals(expected));
  });
}
