import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelman/pages/booking_page/hotel_details.dart';
import 'package:travelman/utils/colors.dart';
import 'package:travelman/utils/next_screen.dart';
import 'package:travelman/utils/wide_button.dart';
import 'package:travelman/widgets/recommendImage.dart';
import 'package:travelman/widgets/textStyles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:travelman/pages/hotel_cards.dart';
import 'flights_widget.dart';

class BookingMain extends StatefulWidget {
  @override
  _BookingMainState createState() => _BookingMainState();
}

class _BookingMainState extends State<BookingMain>
    with SingleTickerProviderStateMixin {
  DateTime selectedDepDate = DateTime.now();
  DateTime selectedArrDate = DateTime.now();
  String country;

  Future<Null> _selectDepDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDepDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDepDate)
      setState(() {
        selectedDepDate = picked;
      });
  }

  Future<Null> _selectArrDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedArrDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedArrDate)
      setState(() {
        selectedArrDate = picked;
      });
  }

  getHotelInfo(String country, String depDate, String arrDate) async {
    var hotelData = await http.get(
        'http://engine.hotellook.com/api/v2/cache.json?location=$country&checkIn=$depDate&checkOut=$arrDate&currency=usd&limit=1&token=f41230bc222d3528d8909d1def2913d3');
    var hotelDataDecoded = jsonDecode(hotelData.body);
    return hotelDataDecoded;
  }

  Future<List<String>> getHotelPics(var hotelsInfo) async {
    List<String> picUrls = [];
    for (var v in hotelsInfo) {
      var hotelId = v["hotelId"].toString();
      var picIds = await http.get(
          'https://yasen.hotellook.com/photos/hotel_photos?id=$hotelId');
      var picIdsDecoded = jsonDecode(picIds.body);
      var picUrl = 'https://photo.hotellook.com/image_v2/limit/${picIdsDecoded[hotelId][0]}/800/520.auto';
      picUrls.add(picUrl);
    }
    return picUrls;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kwhite,
        title:
            Text("booking", style: TextStyle(fontSize: 25, color: kblack)).tr(),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InfoTextField('search for places'.tr(), (newVal) {
                country = newVal;
              }, 'Name of the city'.tr()),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 185,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: GestureDetector(
                      onTap: () => _selectDepDate(context),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.calendarAlt,
                              color: Colors.black45,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Въезд " +
                                  "${selectedDepDate.toLocal()}".split(' ')[0],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 21,
                  ),
                  Container(
                    height: 45,
                    width: 185,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: GestureDetector(
                      onTap: () => _selectArrDate(context),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.calendarAlt,
                              color: Colors.black45,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Выезд " +
                                  "${selectedArrDate.toLocal()}".split(' ')[0],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              WideButton(
                'Искать',
                () async {
                  var hotelDataDecoded = await getHotelInfo(country, selectedDepDate.toString().substring(0, 10), selectedArrDate.toString().substring(0, 10));
                  var picList = await getHotelPics(hotelDataDecoded);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HotelCards(hotelDataDecoded, picList)));
                },
                kPinBlue,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BoldText("current deals".tr(), 20.0, kblack),
                  BoldText("more".tr(), 16, kdarkBlue),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  nextScreen(context, HotelOverviewPage());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 80,
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 80,
                        height: 200.0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            child: Image.asset(
                              "assets/images/sheraton.jpg",
                              fit: BoxFit.fitHeight,
                            )),
                      ),
                      BoldText("sheraton", 20.0, kblack),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          NormalText("Oran", kgreyDark, 12.0),
                          Icon(
                            Icons.location_on,
                            color: kgreyDark,
                            size: 16.0,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BoldText("Past order", 20.0, kblack),
                  BoldText("More", 16, kdarkBlue),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 400,
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    RecommendationImage(
                        "assets/images/sheraton.jpg", "Sheraton", "Oran"),
                    RecommendationImage(
                        "assets/images/Meridien.jpg", "Meridien", "Oran"),
                    RecommendationImage(
                        "assets/images/ibis.jpg", "Ibis", "Oran"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
