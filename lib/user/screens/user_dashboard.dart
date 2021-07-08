import 'package:buddy/constants.dart';
import 'package:buddy/user/screens/user_dashboard_pages.dart/calender.dart';
import 'package:buddy/user/screens/user_dashboard_pages.dart/home.dart';
import 'package:buddy/user/screens/user_dashboard_pages.dart/notification_screen.dart';
import 'package:buddy/user/screens/user_dashboard_pages.dart/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserDashBoard extends StatefulWidget {
  static const routeName = 'user-dashboard';

  @override
  _UserDashBoardState createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  int currentTab = 0;
  List<Widget> screens = [
    UserHome(),
    UserCalender(),
    UserNotification(),
    UserProfileScreen()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = UserHome();

  _openPopup(context) {
    Alert(
        context: context,
        title: "Create",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Username',
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          backgroundColor: Colors.black87,
          onPressed: () {
            _openPopup(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: kPrimaryColor,
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //home
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = UserHome();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.black87 : Colors.grey,
                        ),
                        // Text(
                        //   'Home',
                        //   style: TextStyle(
                        //       color: currentTab == 0 ? Colors.blue : Colors.grey),
                        // )
                      ],
                    ),
                  ),
                ),
                //calender
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = UserCalender();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: currentTab == 1 ? Colors.black87 : Colors.grey,
                        ),
                        // Text(
                        //   'Home',
                        //   style: TextStyle(
                        //       color: currentTab == 1 ? Colors.blue : Colors.grey),
                        // )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                //notification
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = UserNotification();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications,
                          color: currentTab == 2 ? Colors.black87 : Colors.grey,
                        ),
                        // Text(
                        //   'Notification',
                        //   style: TextStyle(
                        //       color: currentTab == 2 ? Colors.blue : Colors.grey),
                        // )
                      ],
                    ),
                  ),
                ),
                //profile
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = UserProfileScreen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 3 ? Colors.black87 : Colors.grey,
                        ),
                        // Text(
                        //   'Profile',
                        //   style: TextStyle(
                        //       color: currentTab == 3 ? Colors.blue : Colors.grey),
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
