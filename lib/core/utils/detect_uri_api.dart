class DetectUriApi {
  static String get uriApi => '${_uriApi!}api';

  static set uriApi(String uri) => _uriApi = uri;
  static String? _uriApi;
}
