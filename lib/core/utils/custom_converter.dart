class CustomConverter {
  List<String> toListString({required List<dynamic> list}) =>
      list.map((e) => e as String).toList();
}
