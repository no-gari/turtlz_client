import 'package:turtlz/modules/search/search/view/search_screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:turtlz/modules/mypage/view/my_page_screen.dart';
import 'package:turtlz/modules/store/view/store_screen.dart';
import 'package:turtlz/modules/cart/view/cart_screen.dart';
import 'package:turtlz/modules/menu/view/menu_screen.dart';
import 'package:turtlz/support/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum MenuState { category, search, store, cart, my_page }

extension MenuStateToString on MenuState {
  String get name {
    return ["category", "search", "store", "cart", "my_page"][this.index];
  }

  String get nickName {
    return ["카테고리", "검색", "홈", "카트", "내 계정"][this.index];
  }
}

class MainScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';

  @override
  void initState() {
    super.initState();

    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();
    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
  }

  _changeData(String msg) => setState(() => notificationData = msg);
  _changeBody(String msg) => setState(() => notificationBody = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);

  int pageIndex = 2;

  PageController pageController = PageController();

  void _onPageChanged(int index) => setState(() => pageIndex = index);

  void _onItemTapped(int index) => pageController.jumpToPage(index);

  List<Widget> pageList = [
    MenuScreen(),
    SearchScreen(),
    StoreScreen(),
    CartScreen(),
    MyPageScreen()
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));

    return Scaffold(
        body: PageView(
            children: pageList,
            controller: pageController,
            onPageChanged: _onPageChanged,
            physics: const NeverScrollableScrollPhysics()),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black, width: 1))),
          child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: List.generate(
                  MenuState.values.length,
                  (index) => BottomNavigationBarItem(
                      label: '',
                      icon: ImageIcon(Svg(
                          "assets/icons/${MenuState.values[index].name}.svg")))),
              onTap: _onItemTapped,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: const Color(0xFF979797),
              currentIndex: pageIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              elevation: 0),
        ));
  }
}
