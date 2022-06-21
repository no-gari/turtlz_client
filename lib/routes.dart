import 'package:turtlz/modules/brands/brand_detail/view/brand_detail_screen.dart';
import 'package:turtlz/modules/notification/notification_detail/view/notification_detail_screen.dart';
import 'package:turtlz/modules/store/product/product_detail/view/product_detail_screen.dart';
import 'package:turtlz/modules/search/search_result/view/search_result_screen.dart';
import 'package:turtlz/modules/search/product_search/product_search_screen.dart';
import 'package:turtlz/modules/search/brand_search/brand_search_screen.dart';
import 'package:turtlz/modules/notification/view/notification_screen.dart';
import 'package:turtlz/modules/search/view/search_screen.dart';
import 'package:turtlz/modules/mypage/view/mypage_screen.dart';
import 'package:turtlz/modules/store/view/store_screen.dart';
import 'package:turtlz/modules/menu/view/menu_screen.dart';
import 'package:turtlz/modules/cart/view/cart_screen.dart';
import 'package:turtlz/modules/main/main_screen.dart';
import 'package:vrouter/vrouter.dart';

final routes = [
  VWidget(path: MainScreen.routeName, widget: MainScreen(), stackedRoutes: [
    VWidget(
        path: '/brand/:brandId',
        widget: BrandDetailScreen(),
        name: BrandDetailScreen.routeName),
    VWidget(path: MenuScreen.routeName, widget: MenuScreen()),
    VWidget(path: StoreScreen.routeName, widget: StoreScreen()),
    VWidget(path: CartScreen.routeName, widget: CartScreen()),
    VWidget(path: MyPageScreen.routeName, widget: MyPageScreen()),
    VWidget(path: SearchScreen.routeName, widget: SearchScreen()),
    VWidget(
        path: 'product/:productId',
        widget: ProductDetailScreen(),
        name: '/productDetail'),
    VWidget(
        path: NotificationScreen.routeName,
        widget: NotificationScreen(),
        name: '/notification',
        stackedRoutes: [
          VWidget(
              path: ':id',
              widget: NotificationDetailScreen(),
              name: '/notificationDetail')
        ]),
    VWidget(
        path: 'search/:keyword',
        widget: SearchResultScreen(),
        name: '/search_result',
        stackedRoutes: [
          VWidget(
              path: 'product/:keyword',
              widget: ProductSearchScreen(),
              name: '/search_product_result'),
          VWidget(
              path: 'brand/:keyword',
              widget: BrandSearchScreen(),
              name: '/search_brand_result'),
        ]),
  ]),
  VWidget(path: '*', widget: MainScreen())
];
