import 'package:flutter/material.dart';
import 'package:travelman/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HotelCards extends StatefulWidget {
  final String country;
  final String depDate;
  final String arrDate;

  HotelCards(this.country, this.depDate, this.arrDate);

  @override
  _HotelCardsState createState() => _HotelCardsState();
}

class _HotelCardsState extends State<HotelCards> {
  List<Widget> hotelCards = [];

  var hotelsInfo;
  var picList;

  getHotelInfo(String country, String depDate, String arrDate) async {
    var hotelData = await http.get(
        'http://engine.hotellook.com/api/v2/cache.json?location=$country&checkIn=$depDate&checkOut=$arrDate&currency=usd&limit=5&token=f41230bc222d3528d8909d1def2913d3');
    var hotelDataDecoded = jsonDecode(hotelData.body);
    hotelsInfo = hotelDataDecoded;
  }

  Future<List<String>> getHotelPics(var hotelsInfo) async {
    List<String> picUrls = [];
    for (var v in hotelsInfo) {
      var hotelId = v["hotelId"].toString();
      var picIds = await http
          .get('https://yasen.hotellook.com/photos/hotel_photos?id=$hotelId');
      var picIdsDecoded = jsonDecode(picIds.body);
      var picUrl =
          'https://photo.hotellook.com/image_v2/limit/${picIdsDecoded[hotelId][0]}/400/250.auto';
      picUrls.add(picUrl);
    }
    picList = picUrls;
  }

  void createCards() {
    int i = 0;
    for (var v in hotelsInfo) {
      Widget hotelCard = HotelCardWidget(
          picList[i],
          '${v["location"]["name"]} - ${v["location"]["country"]}',
          v["priceFrom"].round().toString(),
          v["hotelName"],
          widget.depDate,
          widget.arrDate);
      setState(() {
        hotelCards.add(hotelCard);
      });
      i++;
    }
  }

  @override
  void initState() {
    super.initState();
    getHotelInfo(widget.country, widget.depDate, widget.arrDate).then((value) {
      getHotelPics(hotelsInfo).then((value) {
        createCards();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite,
        title:
            Text("booking", style: TextStyle(fontSize: 25, color: kblack)).tr(),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Results'.tr(),
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.w900))
                          .tr()),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  flex: 6,
                  child: ListView.builder(
                    itemCount: hotelCards.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          hotelCards[index],
                          SizedBox(
                            height: 45,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            hotelCards.isEmpty
                ? Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class HotelCardWidget extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String imageUrl;
  final String country;
  final String price;
  final String hotelName;
  final String depDate;
  final String arrDate;

  HotelCardWidget(this.imageUrl, this.country, this.price, this.hotelName,
      this.depDate, this.arrDate);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 2 / 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 20, 5, 5),
                //EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hotelName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          country,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        Row(
                          children: [
                            Text(
                              '\$ $price',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              color: Colors.black,
                              onPressed: () {
                                String timestamp = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                firestore
                                    .collection('Booking')
                                    .doc(timestamp)
                                    .set({
                                  'hotelName': hotelName,
                                  'price': price,
                                  'depDate': depDate,
                                  'arrDate': arrDate,
                                  'imageUrl': imageUrl,
                                  'timestamp': timestamp,
                                });
                                BotToast.showText(text: "booked!");
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
