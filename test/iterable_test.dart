import 'package:fun/iterable.dart';
import 'package:test/test.dart';

void main() {
  test('alphabetical', () {
    final list = ['c', 'a', 'b'];
    expect(list.alphabetical((item) => item), equals(['a', 'b', 'c']));
    expect(
        list.alphabetical((item) => item, desc: true), equals(['c', 'b', 'a']));
  });
}
