import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travelman/models/state.dart';

class StateBloc extends ChangeNotifier {
  DocumentSnapshot _lastVisible;
  DocumentSnapshot get lastVisible => _lastVisible;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<StateModel> _data = [];
  List<StateModel> get data => _data;

  List<DocumentSnapshot> _snap = new List<DocumentSnapshot>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _hasData;
  bool get hasData => _hasData;

  Future<Null> getData(mounted) async {
    _hasData = true;
    QuerySnapshot rawData;

    if (_lastVisible == null)
      rawData = await firestore
          .collection('states')
          .orderBy('timestamp', descending: false)
          .limit(10)
          .get();
    else
      rawData = await firestore
          .collection('states')
          .orderBy('timestamp', descending: false)
          .startAfter([_lastVisible['timestamp']])
          .limit(10)
          .get();

    if (rawData != null && rawData.docs.length > 0) {
      _lastVisible = rawData.docs[rawData.docs.length - 1];
      if (mounted) {
        _isLoading = false;
        _snap.addAll(rawData.docs);
        _data = _snap.map((e) => StateModel.fromFirestore(e)).toList();
      }
    } else {
      if (_lastVisible == null) {
        _isLoading = false;
        _hasData = false;
        print('no items');
      } else {
        _isLoading = false;
        _hasData = true;
        print('no more items');
      }
    }

    notifyListeners();
    return null;
  }

  setLoading(bool isloading) {
    _isLoading = isloading;
    notifyListeners();
  }

  onRefresh(mounted) {
    _isLoading = true;
    _snap.clear();
    _data.clear();
    _lastVisible = null;
    getData(mounted);
    notifyListeners();
  }

  onReload(mounted) {
    _isLoading = true;
    _snap.clear();
    _data.clear();
    _lastVisible = null;
    getData(mounted);
    notifyListeners();
  }
}
