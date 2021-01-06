import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelman/pages/booking_page/hotel_details.dart';
import 'package:travelman/utils/colors.dart';
import 'package:travelman/utils/next_screen.dart';
import 'package:travelman/utils/wide_button.dart';
import 'package:travelman/widgets/custom_cache_image.dart';
import 'package:travelman/widgets/booking_page_list.dart';
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
  var picList;
  var currentDealsJson;

  List<Widget> currentDeals = [];
  List<String> currentDealsPicsUrls = [];

  getBookingMainInfo(String latitude, String longitude) async {
    var bookingPageData = await http.get(
        'http://engine.hotellook.com/api/v2/lookup.json?query=$latitude,$longitude&lang=en&lookFor=both&limit=5&token=f41230bc222d3528d8909d1def2913d3');
    var bookingPageDataDecoded = jsonDecode(bookingPageData.body);
    // setState(() {
    currentDealsJson = bookingPageDataDecoded;
    //});
  }

  getCurrentDealsPicsUrls(var bookingPageDataDecoded) async {
    List<String> picUrls = [];
    for (var v in bookingPageDataDecoded["results"]["hotels"]) {
      var hotelId = v["id"].toString();
      var picIds = await http
          .get('https://yasen.hotellook.com/photos/hotel_photos?id=$hotelId');
      var picIdsDecoded = jsonDecode(picIds.body);
      var picUrl =
          'https://photo.hotellook.com/image_v2/limit/${picIdsDecoded[hotelId][0]}/400/250.auto';
      picUrls.add(picUrl);
    }
    // setState(() {
    picList = picUrls;
    // });
  }

  generateCurrentDealWidgets() {
    int piclistIndex = 0;
    for (var v in currentDealsJson["results"]["hotels"]) {
      Widget currentDeal = InkWell(
        child: Container(
          margin: EdgeInsets.only(left: 0, right: 10, top: 5, bottom: 5),
          width: MediaQuery.of(context).size.width * 0.36,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Hero(
                tag: 'anime$piclistIndex',
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomCacheImage(imageUrl: picList[piclistIndex])),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: Text(
                    v["name"],
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () => nextScreen(context, HotelOverviewPage()),
      );
      piclistIndex++;
      setState(() {
        currentDeals.add(currentDeal);
      });
    }
  }
/*
  InkWell(
  onTap: () {
  nextScreen(context, HotelOverviewPage());
  },
  child: RecommendationImage(
  picList[piclistIndex],
  v["name"],
  currentDealsJson["results"]["locations"][0]["name"],
  ),
  )


 */
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

  @override
  void initState() {
    super.initState();
    getBookingMainInfo('53.408777', '-2.981006').then((value) {
      getCurrentDealsPicsUrls(currentDealsJson).then((value) {
        generateCurrentDealWidgets();
        print('done');
      });
    });
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                InfoTextField('search for places'.tr(), (newVal) {
                  country = newVal;
                }, 'Name of the city'.tr()),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 45,
                        width: 185,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                            Border.all(width: 1, color: Colors.grey)),
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
                                      "${selectedDepDate.toLocal()}"
                                          .split(' ')[0],
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
                    ),
                    SizedBox(
                      width: 21,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 45,
                        width: 185,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                            Border.all(width: 1, color: Colors.grey)),
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
                                      "${selectedArrDate.toLocal()}"
                                          .split(' ')[0],
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
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                WideButton(
                  'Искать',
                      () {
                    String depDateAsString =
                    selectedDepDate.toString().substring(0, 10);
                    String arrDateAsString =
                    selectedArrDate.toString().substring(0, 10);
                    // var hotelDataDecoded = await getHotelInfo(
                    //, depDateAsString, arrDateAsString);
                    //var picList = await getHotelPics(hotelDataDecoded);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HotelCards(country,
                                depDateAsString, arrDateAsString)));
                  },
                  kPinBlue,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Column(
              children: [
                BookingPageList(currentDeals),
              ],
            ),
            Expanded(child: Container(),),
          ],
        ),
      ),
    );
  }
}
