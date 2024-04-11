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
}
