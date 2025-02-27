import 'package:flutter/material.dart';
import 'package:travelman/utils/colors.dart';
import 'package:travelman/widgets/textStyles.dart';

class RecommendationImage extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;

  RecommendationImage(this.imageUrl, this.name, this.location);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 120.0,
            height: 120.0,
            child: ClipRRect(
                borderRadius: new BorderRadius.all(
                  Radius.circular(15),
                ),
                child: Image.network(imageUrl, fit: BoxFit.fitHeight,),
            ),
          ),
          BoldText(name, 16.0, kblack),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NormalText(location, kgreyDark, 12.0),
              Icon(
                Icons.location_on,
                color: kgreyDark,
                size: 12.0,
              )
            ],
          )
        ],
      ),
    );
  }
}
