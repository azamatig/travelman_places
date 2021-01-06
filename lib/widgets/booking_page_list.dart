import 'package:flutter/material.dart';
import 'package:travelman/pages/more_places.dart';
import 'package:travelman/utils/next_screen.dart';
import 'package:travelman/utils/loading_cards.dart';
import 'package:easy_localization/easy_localization.dart';

class BookingPageList extends StatelessWidget {
  final nearbyHotels;
  BookingPageList(this.nearbyHotels);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'Nearby Hotels',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800]),
              ).tr(),
              Spacer(),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () => nextScreen(
                    context,
                    MorePlacesPage(
                      title: 'popular',
                      color: Colors.grey[800],
                    )),
              )
            ],
          ),
        ),
        Container(
          height: 220,
          //color: Colors.green,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              if (nearbyHotels.length < 5) return LoadingPopularPlacesCard();
              return nearbyHotels[index];
              //return LoadingCard1();
            },
          ),
        )
      ],
    );
  }
}

