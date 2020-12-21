import 'package:flutter/material.dart';
import 'package:travelman/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class HotelCards extends StatelessWidget {
  final hotelsInfo;
  final picList;
  HotelCards(this.hotelsInfo, this.picList);

  List<Widget> hotelCards = [];

  void createCards() {
    int i = 0;
    for (var v in hotelsInfo) {
      Widget hotelCard = HotelCardWidget(picList[i], '${v["location"]["name"]} - ${v["location"]["country"]}', v["priceFrom"].round().toString(), v["hotelName"]);
      hotelCards.add(hotelCard);
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    createCards();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Align(alignment: Alignment.bottomLeft,child: Text('Results'.tr(), style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)).tr()),
            ),
            SizedBox(height: 15,),
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
      ),
    );
  }
}

class HotelCardWidget extends StatelessWidget {
  final String imageUrl;
  final String country;
  final String price;
  final String hotelName;

  HotelCardWidget(this.imageUrl, this.country, this.price, this.hotelName);

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
                padding: EdgeInsets.fromLTRB(15, 20, 5, 5),//EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                          style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        Row(
                          children: [
                            Text(
                              '\$ $price',
                              style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              color: Colors.black,
                              onPressed: (){

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