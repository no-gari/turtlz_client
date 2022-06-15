import 'package:turtlz/modules/magazine/view/magazine_screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:turtlz/modules/mypage/view/my_page_screen.dart';
import 'package:turtlz/modules/store/view/store_screen.dart';
import 'package:turtlz/modules/home/view/home_screen.dart';
import 'package:turtlz/support/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum MenuState { home, magazine, store, my_page }

extension MenuStateToString on MenuState {
  String get name {
    return ["home", "magazine", "store", "my_page"][this.index];
  }

  String get nickName {
    return ["홈", "매거진", "스토어", "내 계정"][this.index];
  }
}

class MainScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Noti noti = kIsWeb ? WebNoti() : AppNoti();

  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';

  @override
  void initState() {
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();
    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
    // Future(noti.init);

    super.initState();
  }

  _changeData(String msg) => setState(() => notificationData = msg);
  _changeBody(String msg) => setState(() => notificationBody = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);

  int pageIndex = 0;

  PageController pageController = PageController();

  void _onPageChanged(int index) => setState(() => pageIndex = index);

  void _onItemTapped(int index) => pageController.jumpToPage(index);

  List<Widget> pageList = [
    HomeScreen(),
    MagazineScreen(),
    StoreScreen(),
    MyPageScreen()
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));

    return Scaffold(
        body: PageView(
            children: pageList,
            controller: pageController,
            onPageChanged: _onPageChanged,
            physics: NeverScrollableScrollPhysics()),
        bottomNavigationBar: BottomNavigationBar(
            items: List.generate(
                MenuState.values.length,
                (index) => BottomNavigationBarItem(
                    icon: ImageIcon(Svg(
                        "assets/icons/bottomNavigationBar/${MenuState.values[index].name}.svg")),
                    label: "${MenuState.values[index].nickName}")),
            onTap: _onItemTapped,
            selectedItemColor: Colors.white,
            unselectedItemColor: Color(0xFF979797),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
            currentIndex: pageIndex,
            selectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            elevation: 0));
  }
}
