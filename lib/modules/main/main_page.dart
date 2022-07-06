import 'package:turtlz/repositories/authentication_repository/authentication_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/support/base_component/login_needed.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:turtlz/modules/mypage/view/mypage_screen.dart';
import 'package:turtlz/modules/search/view/search_screen.dart';
import 'package:turtlz/modules/store/view/store_screen.dart';
import 'package:turtlz/modules/cart/view/cart_screen.dart';
import 'package:turtlz/modules/menu/view/menu_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

enum MenuState { category, search, store, cart, my_page }

extension MenuStateToString on MenuState {
  String get name {
    return const ["category", "search", "store", "cart", "my_page"][this.index];
  }

  String get nickName {
    return const ["카테고리", "검색", "홈", "카트", "내 계정"][this.index];
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController = PageController();
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 2);
    _pageIndex = 2;
  }

  void _onPageChanged(int index) => setState(() => _pageIndex = index);

  void _onItemTapped(int index) => _pageController.jumpToPage(index);

  List<Widget> pageList = [
    MenuScreen(),
    SearchScreen(),
    StoreScreen(),
    CartScreen(),
    MyPageScreen()
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ScaffoldContext) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return Scaffold(
          body: DoubleBack(
              message: '앱을 닫으시려면 한 번 더 눌러주세요.',
              child: PageView(
                  children: pageList,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  physics: const NeverScrollableScrollPhysics())),
          bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.black, width: 1))),
              child: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: List.generate(
                      MenuState.values.length,
                      (index) => BottomNavigationBarItem(
                          label: '',
                          icon: ImageIcon(Svg(
                              "assets/icons/${MenuState.values[index].name}.svg")))),
                  onTap: (context) {
                    if (state.status != AuthenticationStatus.authenticated &&
                        context == 3) {
                      showSocialLoginNeededDialog(ScaffoldContext);
                    } else {
                      _onItemTapped(context);
                    }
                  },
                  selectedItemColor: Theme.of(context).primaryColor,
                  unselectedItemColor: const Color(0xFF979797),
                  currentIndex: _pageIndex,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  elevation: 0)));
    });
  }
}
