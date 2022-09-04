import 'package:cloud_firestore/cloud_firestore.dart';

class PaginaterFirestore {
  final Query query;
  bool _lazy = true;
  bool _noMoreData = false;
  bool _tempNoMoreData = false;
  QueryDocumentSnapshot? _last;
  QueryDocumentSnapshot? _tempLast;

  PaginaterFirestore({required this.query});

  Future<QuerySnapshot<Object?>?> fetch({required int limit}) async {
    if (_lazy == true) {
      _last = null;
      _tempLast = null;
      _noMoreData = false;
      _tempNoMoreData = false;
    }
    if (noMoreData == true) return Future.value(null);
    _lazy = false;
    Query pagQuery = query.limit(limit);
    if (_last != null) pagQuery = pagQuery.startAfterDocument(_last!);
    var response = await pagQuery.get();
    if (response.docs.length < limit) {
      _tempNoMoreData = true;
      _tempLast = null;
    } else {
      _tempLast = response.docs[response.docs.length - 1];
    }
    return Future.value(response);
  }

  void commitFetching() {
    _last = _tempLast;
    _noMoreData = _tempNoMoreData;
  }

  bool get noMoreData => _noMoreData;

  void refresh() => _lazy = true;
}
