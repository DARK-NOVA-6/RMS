class CustomConverter {
  List<String> toListString({required List<dynamic> list}) =>
      list.map((e) => e as String).toList();

  static List<Map<String, dynamic>> convertToListMap(List<dynamic> list) {
    return list.map((e) => e as Map<String, dynamic>).toList();
  }
}
