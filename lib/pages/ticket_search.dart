import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travelman/blocs/ads_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:travelman/pages/tickets_page.dart';

class TicketSearch extends StatefulWidget {
  TicketSearch({Key key}) : super(key: key);

  _TicketSearchState createState() => _TicketSearchState();
}

class _TicketSearchState extends State<TicketSearch> {
  int prevPage;
  List<dynamic> _alldata = List<dynamic>();

  void openEmptyDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("we didn't find any nearby hotels in this area").tr(),
            title: Text(
              'no hotels found',
              style: TextStyle(fontWeight: FontWeight.w700),
            ).tr(),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  Future getData() async {
    http.Response response =
        await http.get('https://api.travelpayouts.com/data/en/countries.json');
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
    return values;
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 0)).then((value) async {
      context.read<AdsBloc>().initiateAds();
    });
    getData().then((value) => _alldata.add(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            TicketsPage(),
          ],
        ),
      ),
    );
  }
}
