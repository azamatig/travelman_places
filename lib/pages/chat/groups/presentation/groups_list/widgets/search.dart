import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uic/list_uic.dart';

import '../../../export.dart';
import '../../widgets/group_avatar.dart';

class GroupsSearch extends StatefulWidget {
  @override
  _GroupsSearchState createState() => _GroupsSearchState();
}

class _GroupsSearchState extends State<GroupsSearch> {
  final repo = Modular.get<GroupsRepository>();
  ListUicController<Group> groupListController;
  @override
  void initState() {
    super.initState();
    groupListController = ListUicController<Group>(
      onGetItems: (page) => repo.fetchAllGroups(page: page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SearchBar<Group>(
            icon: BackButton(),
            mainAxisSpacing: 0,
            onSearch: Modular.get<GroupsRepository>().groupsSearch,
            textStyle: TextStyle(color: Colors.white),
            minimumChars: 2,
            searchBarStyle: SearchBarStyle(
              backgroundColor: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            cancellationWidget: Icon(Icons.close),
            shrinkWrap: true,
            onItemFound: (group, _) => ListTile(
              leading: GroupAvatar(photoUrl: group.photoUrl),
              title: Text(group.name),
              onTap: () {
                FocusScope.of(context).unfocus();
                GroupsModule.toGroupDetails(group);
              },
            ),
            placeHolder: ListUic<Group>(
              controller: groupListController,
              itemBuilder: (group) => ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 4),
                leading: GroupAvatar(photoUrl: group.photoUrl, radius: 40),
                title: Text(
                  group.name,
                  style: GoogleFonts.basic(
                      textStyle: Theme.of(context).textTheme.subtitle1),
                ),
                onTap: () => GroupsModule.toGroupDetails(group),
              ),
              emptyProgressView: SpinKitCircle(color: Colors.green),
            ),
          ),
        ),
      ),
    );
  }
}
