import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:travelman/utils/colors.dart';
import 'package:travelman/utils/wide_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:travelman/blocs/sign_in_bloc.dart';

// ignore: must_be_immutable
class TicketInfoScreen extends StatelessWidget {
  final flightDataDecoded;
  final String origin;
  final String destination;
  final String depDate;
  final String retDate;

  TicketInfoScreen(this.flightDataDecoded, this.origin, this.destination,
      this.depDate, this.retDate);

  List<Widget> airfares = [];

  void createAirfares(var context) {
    for (var v in flightDataDecoded["data"][destination]?.values) {
      //String airline = '${v['airline']}';
      Widget airfare = Ticket(v, origin, destination);
      airfares?.add(airfare);
    }
  }

  @override
  Widget build(BuildContext context) {
    createAirfares(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('best deals'.tr()),
        centerTitle: true,
        backgroundColor: Color(0xffF8F9F9),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Color(0xffF8F9F9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'origin'.tr(),
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text(
                          origin,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '$depDate   -   $retDate',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'destination'.tr(),
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text(
                          destination,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text('${airfares.length}' + ' search results'.tr(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
            SizedBox(
              height: 25,
            ),
            Expanded(
              flex: 5,
              child: ListView.builder(
                itemCount: airfares.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      airfares[index],
                      SizedBox(height: 45),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Ticket extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final v;
  final origin;
  final destination;
  String clientFirstName = " ";
  String clientSecondName = " ";
  String clientPhone = " ";
  String clientEmail = " ";
  Ticket(this.v, this.origin, this.destination);

  Widget builderBottomSheet(BuildContext context, var v) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kwhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: ListView(
        children: [
          BottomSheetTextField(
            (newVal) {
              clientFirstName = newVal;
            },
            'First Name',
          ),
          SizedBox(height: 16),
          BottomSheetTextField(
            (newVal) {
              clientSecondName = newVal;
            },
            'Second Name',
          ),
          SizedBox(height: 16),
          BottomSheetTextField(
            (newVal) {
              clientPhone = newVal;
            },
            'phone number',
          ),
          SizedBox(height: 16),
          BottomSheetTextField(
            (newVal) {
              clientEmail = newVal;
            },
            'email address',
          ),
          SizedBox(height: 16),
          WideButton('book now'.tr(), () {
            String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
            firestore.collection('tickets').doc(timestamp).set({
              'origin': origin,
              'destination': destination,
              'price': '${v["price"].toString()}' + '  ' + 'currency'.tr(),
              'depDate': v["departure_at"],
              'arrDate': v["return_at"],
              'airline': '${v['airline']}',
              'clientName': '$clientFirstName $clientSecondName',
              'clientPhone': clientPhone,
              'clientEmail': clientEmail,
              'clientAvatar':
                  "https://3znvnpy5ek52a26m01me9p1t-wpengine.netdna-ssl.com/wp-content/uploads/2017/07/noimage_person.png",
              'timestamp': timestamp,
            });
            Navigator.pop(context);
            //BotToast.showText(text: "booked!");
          }, kPinBlue),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String airline = '${v['airline']}';
    final sb = context.watch<SignInBloc>();
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    v["departure_at"].substring(11, 16),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    origin,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              DottedLine(
                direction: Axis.horizontal,
                lineLength: 140,
                dashGapLength: 15,
                lineThickness: 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    v["return_at"].substring(11, 16),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    destination,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 50),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    child: Image.asset(
                        'assets/images/airline_logos/$airline.png' ?? ''),
                  ),
                  Text(
                    '$airline',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Spacer(),
              Container(
                child: Text(
                  '${v["price"].toString()}' + '  ' + 'currency'.tr(),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          WideButton('book now'.tr(), () {
            if (sb.isSignedIn == false) {
              showModalBottomSheet(
                context: context,
                builder: (context) => builderBottomSheet(context, v),
                backgroundColor: Colors.transparent,
              );
            } else {
              String timestamp =
                  DateTime.now().millisecondsSinceEpoch.toString();
              firestore.collection('tickets').doc(timestamp).set({
                'origin': origin,
                'destination': destination,
                'price': '${v["price"].toString()}' + '  ' + 'currency'.tr(),
                'depDate': v["departure_at"],
                'arrDate': v["return_at"],
                'airline': '${v['airline']}',
                'clientName': sb.name,
                'clientPhone': '',
                'clientEmail': sb.email,
                'clientAvatar': sb.imageUrl,
                'timestamp': timestamp,
              });
              Navigator.pop(context);
            }
          }, kPinBlue),
        ],
      ),
    );
  }
}

class BottomSheetTextField extends StatelessWidget {
  final updateString;
  final hintText;

  BottomSheetTextField(this.updateString, this.hintText);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.start,
      onChanged: updateString,
      decoration: InputDecoration(
        hintText: hintText,
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
    );
  }
}
