import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:travelman/pages/booking_page/booking_info.dart';
import 'package:travelman/utils/colors.dart';
import 'package:travelman/utils/next_screen.dart';
import 'package:travelman/widgets/consts_temp.dart';
import 'package:easy_localization/easy_localization.dart';

class TicketSearchScreen extends StatefulWidget {
  @override
  _TicketSearchScreenState createState() => _TicketSearchScreenState();
}

class _TicketSearchScreenState extends State<TicketSearchScreen> {
  String origin;

  String destination;

  String depDate;

  String retDate;

  List<Widget> popularRoutes = [];

  getFlightData(
      String origin, String destination, String depDate, String retDate) async {
    var flightData = await http.get(
        'https://api.travelpayouts.com/v1/prices/cheap?origin=$origin&destination=$destination&depart_date=$depDate&return_date=$retDate&token=$kToken&currency=USD');
    var flightDataDecoded = jsonDecode(flightData.body);
    return flightDataDecoded;
  }

  createPopularRoutes() async {
    var routesDataDecoded = await getPopularRoutes();
    int currentImg = 1;
    routesDataDecoded["data"].forEach((k, v) {
      Widget popularRoute = PopularRoute(k, v, currentImg);
      currentImg++;
      setState(() {
        popularRoutes.add(popularRoute);
      });
    });
  }

  getPopularRoutes() async {
    var routesData = await http.get(
        'https://api.travelpayouts.com/v1/airline-directions?&limit=5&token=f41230bc222d3528d8909d1def2913d3');
    var routesDataDecoded = jsonDecode(routesData.body);
    return routesDataDecoded;
  }

  showAlertDialog(BuildContext context, String info) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Something went wrong".tr()),
      content: Text(info),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    createPopularRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flight search'.tr()),
        centerTitle: true,
        backgroundColor: Color(0xffF8F9F9),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 30, 25, 15),
        child: ListView(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    InfoTextField('origin'.tr(), (newVal) {
                      origin = newVal;
                    }, '3 letter IATA code, example: MOW'.tr()),
                    SizedBox(height: 16),
                    InfoTextField(
                      'destination'.tr(),
                      (newVal) {
                        destination = newVal;
                      },
                      '3 letter IATA code, example: MOW'.tr(),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: InfoTextField('departure'.tr(), (newVal) {
                            depDate = newVal;
                          }, 'yyyy-mm-dd'),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: InfoTextField('return'.tr(), (newVal) {
                            retDate = newVal;
                            print(origin);
                          }, 'yyyy-mm-dd'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: InfoTextField('passengers'.tr(), null, null),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: InfoTextField('class'.tr(), null, null),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Material(
                  elevation: 5.0,
                  color: kPinBlue,
                  borderRadius: BorderRadius.circular(8),
                  child: MaterialButton(
                    onPressed: () async {
                      var flightDataDecoded = await getFlightData(
                          origin, destination, depDate, retDate);
                      if (flightDataDecoded["success"] == false) {
                        showAlertDialog(context, flightDataDecoded["error"]);
                      } else if (flightDataDecoded["data"].length == 0) {
                        showAlertDialog(
                            context, 'Sorry, no tickets available'.tr());
                      } else {
                        nextScreen(
                          context,
                          TicketInfoScreen(flightDataDecoded, origin,
                              destination, depDate, retDate),
                        );
                      }
                    },
                    minWidth: double.infinity,
                    height: 60,
                    child: Text(
                      'search'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Popular routes:'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularRoutes.length,
                itemBuilder: (context, index) {
                  return popularRoutes[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopularRoute extends StatelessWidget {
  final route;
  final price;
  final imgNum;

  PopularRoute(this.route, this.price, this.imgNum);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$route: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
                Text(
                  '$price₽',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22),
                ),
              ],
            ),
            decoration: BoxDecoration(
              //border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(7),
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/nature/poproute$imgNum.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.fromLTRB(5, 90, 5, 8)),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}

class InfoTextField extends StatelessWidget {
  final String hintText;
  final String hintText2;
  final updateString;

  InfoTextField(this.hintText, this.updateString, this.hintText2);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 8),
        TextField(
          textAlign: TextAlign.start,
          onChanged: updateString,
          decoration: InputDecoration(
            hintText: hintText2,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kPinBlue,
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
