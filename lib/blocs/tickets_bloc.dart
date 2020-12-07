import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travelman/models/tickets.dart';
import 'package:http/http.dart' as http;

// TODO: finish this bloc, make it proper
class TicketsBloc extends ChangeNotifier {
  DocumentSnapshot _lastVisible;
  DocumentSnapshot get lastVisible => _lastVisible;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Tickets> _data = [];
  List<Tickets> get data => _data;

  String _popSelection = 'popular';
  String get popupSelection => _popSelection;

  List<DocumentSnapshot> _snap = new List<DocumentSnapshot>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _hasData;
  bool get hasData => _hasData;
  List<dynamic> _alldata = List<dynamic>();

  Future getData(mounted, String orderBy) async {
    http.Response response = await http.get(
        'https://api.travelpayouts.com/v1/prices/cheap?origin=ALA&destination=MOW&depart_date=2020-12&return_date=2020-12&token=f41230bc222d3528d8909d1def2913d3&currency=KZT');
    List<dynamic> values = List<dynamic>();
    values = json.decode(response.body);
    if (values.length > 0) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          _alldata.add(values);
        }
      }
    }
    notifyListeners();
    return values;
  }

  afterPopSelection(value, mounted, orderBy) {
    _popSelection = value;
    onRefresh(mounted, orderBy);
    notifyListeners();
  }

  setLoading(bool isloading) {
    _isLoading = isloading;
    notifyListeners();
  }

  onRefresh(mounted, orderBy) {
    _isLoading = true;
    _snap.clear();
    _data.clear();
    _lastVisible = null;
    getData(mounted, orderBy);
    notifyListeners();
  }
}
