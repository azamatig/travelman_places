import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travelman/blocs/sign_in_bloc.dart';
import 'package:travelman/utils/loading_cards.dart';
import 'package:travelman/widgets/consts_temp.dart';
import 'package:travelman/widgets/textStyles.dart';
import 'package:provider/provider.dart';

class UserPostSection extends StatefulWidget {
  UserPostSection({
    Key key,
  }) : super(key: key);

  @override
  _UserPostSectionState createState() => _UserPostSectionState();
}

class _UserPostSectionState extends State<UserPostSection> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0)).then((value) {
      context.read<SignInBloc>().getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pb = context.watch<SignInBloc>();
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(top: 30.0, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Мои фото',
            style: AppTextStyles.subHeaderTextStyle,
          ),
          SizedBox(height: 10.0),
          Container(
            height: screenWidth * 0.5,
            child: ListView.builder(
              itemCount: pb.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                var item = pb.data[index];
                return pb.data.isEmpty || pb.data == null
                    ? LoadingPopularPlacesCard()
                    : PhotoCard(photo: item.imgUrl);
              },
            ),
          )
        ],
      ),
    );
  }
}

class PhotoCard extends StatelessWidget {
  final String photo;

  const PhotoCard({Key key, @required this.photo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final BorderRadius br = BorderRadius.circular(20.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
      child: Material(
        elevation: 4.0,
        borderRadius: br,
        child: Container(
          width: screenWidth * 0.3,
          height: screenWidth * 0.3,
          decoration: BoxDecoration(
              color: unselectedCardColor,
              borderRadius: br,
              image: DecorationImage(
                  image: CachedNetworkImageProvider(photo), fit: BoxFit.cover)),
          child: Center(
            child: Icon(
              Icons.add,
              size: 40.0,
              color: Colors.grey.withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}
