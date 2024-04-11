library iterable;

extension FunIterable<T> on Iterable<T> {
  /// Sorts an array of objects alphabetically by a property.
  ///
  /// Example:
  /// ```dart
  /// final list = ['c', 'a', 'b'];
  /// final sorted = list.alphabetical((item) => item);
  /// print(sorted); // ['a', 'b', 'c']
  /// ```
  ///
  /// - `getter`: The property to sort by.
  /// - `desc`: Sort in descending order, default is `false`.
  List<T> alphabetical(String Function(T item) getter, {bool desc = false}) {
    return toList()
      ..sort(
        (a, b) => desc
            ? getter(b).compareTo(getter(a))
            : getter(a).compareTo(getter(b)),
      );
  }

  /// Split a list into many lists of the given size.
  ///
  /// Given an array of items and a desired cluster size (`n`), returns an
  /// array of arrays.
  /// Each child array containing `n` (cluster size) items split as evenly as
  /// possible.
  ///
  /// Example:
  ///
  /// ```dart
  /// final data = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  /// final clusters = data.cluster(3);
  ///
  /// print(clusters); // [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  /// ```
  ///
  /// - `size`: The size of each cluster.
  Iterable<Iterable<T>> cluster(int size) sync* {
    for (int i = 0; i < length; i += size) {
      yield skip(i).take(size);
    }
  }
}

void main(List<String> args) {
  // final list = ['c', 'a', 'b'];
  // print(list.alphabetical((item) => item)); // ['a', 'b', 'c']
  // print(list.alphabetical((item) => item, desc: true)); // ['c', 'b', 'a']

  final data = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  final clusters = data.cluster(3);
  print(clusters); // [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
}
