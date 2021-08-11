import 'package:buddy/constants.dart';

import 'package:flutter/material.dart';

class GroupMemberScreen extends StatefulWidget {
  const GroupMemberScreen({Key? key}) : super(key: key);

  @override
  _GroupMemberScreenState createState() => _GroupMemberScreenState();
}

class _GroupMemberScreenState extends State<GroupMemberScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _showOnlyFavourites = false;

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.black,
          expandedHeight: 100.0,
          floating: false,
          pinned: true,
          iconTheme: IconThemeData(color: Colors.black),
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Members',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    )),
                Divider()
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                          ),
                          title: Text("Parneet"),
                        ),
                        Divider()
                      ],
                    ),
                  ),
              childCount: 20),
        )
      ]),
    );
  }
}
