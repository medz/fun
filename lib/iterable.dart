library iterable;

extension FunIterable<T> on Iterable<T> {
  /// Sorts an [Iteravle] of [T] alphabetically by a property.
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
  /// Given an [Iteravle] of items and a desired cluster size (`n`), returns an
  /// [Iteravle] of [Iteravle]s.
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

  /// Creates an object with counts of occurrences of items in an [Iterable].
  ///
  /// Example:
  ///
  /// ```dart
  /// final list = ['a', 'b', 'a', 'c', 'b', 'a'];
  /// final counts = list.counting((item) => item);
  /// print(counts); // {a: 3, b: 2, c: 1}
  ///
  /// final list2 = [
  ///   (1, 'a'),
  ///   (2, 'b'),
  ///   (3, 'a'),
  ///   (4, 'c'),
  ///   (5, 'b'),
  /// ];
  /// final counts2 = list2.counting((item) => item.$2);
  ///
  /// print(counts2); // {a: 2, b: 2, c: 1}
  /// ```
  ///
  /// - `getter`: The callback function to determine the identity of each
  /// item.
  Map<K, int> counting<K>(K Function(T item) getter) {
    final result = <K, int>{};
    for (final item in this) {
      final key = getter(item);
      result[key] = (result[key] ?? 0) + 1;
    }

    return result;
  }

  /// Create an [Iterable] of differences between two [Iteraabl]s.
  ///
  /// Example:
  /// ```dart
  /// final list1 = [1, 2, 3, 4, 5];
  /// final list2 = [1, 2, 3, 4, 6];
  /// final diff = list1.difference(list2);
  /// print(diff); // [5]
  /// ```
  ///
  /// - `other`: The other [Iterable] to compare against.
  Iterable<T> diff(Iterable<T> other) {
    return where((item) => !other.contains(item));
  }

  /// Split an [Iterable] into two [Iterable]s based on a predicate.
  ///
  /// Example:
  /// ```dart
  /// final list = [
  ///   (name: 'Alice', age: 21),
  ///   (name: 'Bob', age: 25),
  ///   (name: 'Charlie', age: 30),
  /// ];
  /// final (young, old) = list.partition((item) => item.age < 30);
  /// print(young); // [(name: Alice, age: 21), (name: Bob, age: 25)]
  /// print(old); // [(name: Charlie, age: 30)]
  /// ```
  (List<T>, List<T>) partition(bool Function(T item) condition) {
    final left = <T>[];
    final right = <T>[];

    for (final item in this) {
      if (condition(item)) {
        left.add(item);
        continue;
      }

      right.add(item);
    }

    return (left, right);
  }

  /// Group an [Iterable] of [T] into a single dimensional iterable.
  ///
  /// Example:
  /// ```dart
  /// final data = [
  ///   (name: 'Marlin', skill: 'Dart'),
  ///   (name: 'Nemo', skill: 'Flutter'),
  ///   (name: 'Dory', skill: 'Dart'),
  ///   (name: 'Bruce', skill: 'JS'),
  /// ];
  /// final grouped = data.groupBy((item) => item.skill);
  ///
  /// print(grouped); // {Dart: [(name: Marlin, skill: Dart), (name: Dory,
  /// skill: Dart)], Flutter: [(name: Nemo, skill: Flutter)], JS: [(name:
  /// Bruce, skill: JS)]}
  /// ```
  Map<K, List<T>> group<K>(K Function(T item) getter) {
    return fold(<K, List<T>>{}, (result, item) {
      final key = getter(item);
      result[key] = [...(result[key] ?? []), item];
      return result;
    });
  }
}

extension FunIterableFlatten<T> on Iterable<Iterable<T>> {
  /// Flatten an array of arrays into a single dimensional iterable.
  ///
  /// Example:
  /// ```dart
  /// final data = [
  ///   [1, 2, 3],
  ///   [4, 5, 6],
  ///   [7, 8, 9],
  /// ];
  /// final flattened = data.flat();
  /// print(flattened); // [1, 2, 3, 4, 5, 6, 7, 8, 9]
  /// ```
  Iterable<T> flat() sync* {
    for (final item in this) {
      yield* item;
    }
  }
}
