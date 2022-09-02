class EncodeUri {
  static Uri encode(String uri) {
    return Uri.parse(Uri.encodeFull(uri).replaceAll('#', '%23'));
  }
}
