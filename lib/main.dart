import 'package:buddy/auth/auth_choice_screen.dart';
import 'package:buddy/auth/phone_auth.dart';
import 'package:buddy/auth/sign_in.dart';
import 'package:buddy/auth/sign_up.dart';
import 'package:buddy/auth/verify.dart';
import 'package:buddy/chat/models/chat_list_provider.dart';
import 'package:buddy/chat/models/chat_search_provider.dart';
import 'package:buddy/chat/models/group_message_name_provider.dart';
import 'package:buddy/chat/screens/group_detail_screen.dart';
import 'package:buddy/chat/screens/user_chat_list.dart';
import 'package:buddy/notification/model/notification_provider.dart';
import 'package:buddy/onboarder/onboarder_widget.dart';
import 'package:buddy/user/models/event_provider.dart';
import 'package:buddy/user/models/follower_provider.dart';
import 'package:buddy/user/models/following_provider.dart';
import 'package:buddy/user/models/home_search_provider.dart';
import 'package:buddy/user/models/user_genre_provider.dart';
import 'package:buddy/user/models/user_provider.dart';
import 'package:buddy/user/screens/connection%20screen/search_connection_screen.dart';
import 'package:buddy/user/screens/genre_searchbar/search_screen.dart';
import 'package:buddy/user/screens/user_dashboard.dart';
import 'package:buddy/user/screens/user_dashboard_pages.dart/screen_helper_provider.dart';
import 'package:buddy/user/screens/user_dashboard_pages.dart/user_profile/user_profile_screen_currentuser.dart';
import 'package:buddy/user/screens/user_genre.dart';
import 'package:buddy/user/screens/user_intial_info.dart';
import 'package:buddy/user/widgets/comments_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'chat/group/screens/create_community_screen.dart';

Map<int, Color> colorCodes = {
  50: Color.fromRGBO(0, 0, 0, .1),
  100: Color.fromRGBO(0, 0, 0, 0.2),
  200: Color.fromRGBO(0, 0, 0, .3),
  300: Color.fromRGBO(0, 0, 0, .4),
  400: Color.fromRGBO(0, 0, 0, .5),
  500: Color.fromRGBO(0, 0, 0, .6),
  600: Color.fromRGBO(0, 0, 0, .7),
  700: Color.fromRGBO(0, 0, 0, .8),
  800: Color.fromRGBO(0, 0, 0, .9),
  900: Color.fromRGBO(0, 0, 0, 1),
};

MaterialColor colorBlack = new MaterialColor(0xFF000000, colorCodes);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => UserGenreProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (ctx) => EventProvider(),
        // ),
        ChangeNotifierProvider(
          create: (ctx) => EventsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ScreenHelperProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => HomeSearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CommentProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ChatSearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ChatListProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => GroupMessageProviderName(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FollowerProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FollowingProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: colorBlack,
          canvasColor: Color(0XFFF1F0E8),
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => AuthWrapper(),
          SignIn.routeName: (ctx) => SignIn(),
          SignUp.routeName: (ctx) => SignUp(),
          PhoneAuth.routeName: (ctx) => PhoneAuth(),
          VerifyEmail.routeName: (ctx) => VerifyEmail(),
          UserGenre.routeName: (ctx) => UserGenre(),
          UserIntialInfo.routeName: (ctx) => UserIntialInfo(),
          UserDashBoard.routeName: (ctx) => UserDashBoard(),
          UserProfileScreen.routeName: (ctx) => UserProfileScreen(),
          OnboarderWidget.routeName: (ctx) => OnboarderWidget(),
          UserChatList.routeName: (ctx) => UserChatList(),
          SearchScreen.routeName: (cts) => SearchScreen(),
          SearchConnectionScreen.routeName: (ctx) => SearchConnectionScreen(),
          CreateCommunityScreen.routeName: (ctx) => CreateCommunityScreen(),
          AuthChoiceScreen.routeName: (ctx) => AuthChoiceScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.hasData) {
          Navigator.of(context).maybePop();
          return UserDashBoard();
        } else {
          return AuthChoiceScreen();
        }
      },
    );
  }
}
