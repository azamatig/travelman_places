import 'package:flutter/material.dart';
import 'package:travelman/pages/booking_page/hotel_details.dart';
import 'package:travelman/utils/colors.dart';
import 'package:travelman/utils/next_screen.dart';
import 'package:travelman/widgets/recommendImage.dart';
import 'package:travelman/widgets/textStyles.dart';
import 'package:easy_localization/easy_localization.dart';

class BookingMain extends StatefulWidget {
  @override
  _BookingMainState createState() => _BookingMainState();
}

class _BookingMainState extends State<BookingMain>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
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
      body: Scaffold(
        backgroundColor: kwhite,
        appBar: TabBar(
          labelColor: kdarkBlue,
          labelStyle:
              TextStyle(fontFamily: "nunito", fontWeight: FontWeight.bold),
          controller: tabController,
          indicatorColor: kdarkBlue,
          tabs: <Widget>[
            Tab(text: "hotels".tr()),
            Tab(text: "trip".tr()),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
            Icon(Icons.restaurant),
          ],
          controller: tabController,
        ),
      ),
    );
  }
}
