import 'package:turtlz/modules/cart/view/cart_screen.dart';
import 'package:turtlz/modules/notification/notification_detail/view/notification_detail_screen.dart';
import 'package:turtlz/modules/notification/view/notification_screen.dart';
import 'package:turtlz/modules/search/search/view/search_screen.dart';
import 'package:turtlz/modules/mypage/view/my_page_screen.dart';
import 'package:turtlz/modules/store/view/store_screen.dart';
import 'package:turtlz/modules/menu/view/menu_screen.dart';
import 'package:turtlz/modules/main/main_screen.dart';
import 'package:vrouter/vrouter.dart';

final routes = [
  VWidget(path: MainScreen.routeName, widget: MainScreen(), stackedRoutes: [
    VWidget(path: MenuScreen.routeName, widget: MenuScreen()),
    VWidget(path: StoreScreen.routeName, widget: StoreScreen()),
    VWidget(path: CartScreen.routeName, widget: CartScreen()),
    VWidget(path: MyPageScreen.routeName, widget: MyPageScreen()),
    VWidget(path: SearchScreen.routeName, widget: SearchScreen()),
    VWidget(
        path: NotificationScreen.routeName,
        widget: NotificationScreen(),
        name: '/notification',
        stackedRoutes: [
          VWidget(
              path: ':id',
              widget: NotificationDetailScreen(),
              name: '/notificationDetail')
        ])
  ]),
  VWidget(path: '*', widget: MainScreen())
];
