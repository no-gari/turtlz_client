import 'package:turtlz/repositories/authentication_repository/authentication_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/modules/orderForm/view/orderForm_list_screen.dart';
import 'package:turtlz/modules/mypage/address/view/address_screen.dart';
import 'package:turtlz/repositories/user_repository/models/user.dart';
import 'package:turtlz/modules/store/coupon/view/coupon_screen.dart';
import 'package:turtlz/support/base_component/company_info.dart';
import 'package:turtlz/support/base_component/login_needed.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'components/menu_widgets.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late User user;
  late bool is_authenticated;
  PackageInfo _packageInfo = PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown');

  @override
  void initState() {
    super.initState();
    user = context.read<AuthenticationBloc>().state.user;
    is_authenticated = context.read<AuthenticationBloc>().state.status ==
        AuthenticationStatus.authenticated;
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() => _packageInfo = info);
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.only(top: 5),
          child:
              Text('my page.', style: Theme.of(context).textTheme.headline3)),
      if (is_authenticated) myPageInfo() else loginNeededProfile(),
      Container(
          color: Colors.white,
          child: Column(children: [
            SizedBox(height: 20),
            shoppingWire(context),
            SizedBox(height: 20),
            helpcenterWire(context),
            SizedBox(height: 20),
            helpcenterWire2(context),
            SizedBox(height: 29),
            if (is_authenticated) logOutMethod(context),
            if (is_authenticated) SizedBox(height: 20),
            // CompanyInfo()
          ]))
    ]);
  }

  Row logOutMethod(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      MaterialButton(
          padding: EdgeInsets.all(10),
          onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(title: Text("로그아웃 하시겠습니까?"), actions: [
                  MaterialButton(
                      onPressed: () =>
                          RepositoryProvider.of<AuthenticationRepository>(
                                  context)
                              .logOut(),
                      child: Text("확인"))
                ]);
              }),
          child: Text('로그아웃',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.grey, decoration: TextDecoration.underline))),
      Container(
          height: 12,
          width: 1,
          color: Colors.grey,
          margin: EdgeInsets.symmetric(horizontal: 30)),
      MaterialButton(
          padding: EdgeInsets.all(10),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(title: Text("회원 탈퇴 하시겠습니까?"), actions: [
                    MaterialButton(
                        onPressed: () {
                          RepositoryProvider.of<AuthenticationRepository>(
                                  context)
                              .signOut();
                        },
                        child: Text("확인"))
                  ]);
                });
          },
          child: Text('회원탈퇴',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.grey, decoration: TextDecoration.underline)))
    ]);
  }

  Column helpcenterWire(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      menuWidget('account.'),
      SizedBox(height: 10),
      Column(children: [
        subMenuWidget(
            title: "1:1 문의하기",
            tapped: () {
              requestCameraPermission(context);
            })
      ])
    ]);
  }

  Column helpcenterWire2(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      menuWidget('service.'),
      SizedBox(height: 10),
      Column(children: [
        subMenuWidget(
            title: "개인정보 처리방침",
            tapped: () =>
                isWebRouter(context, 'https://aroundusprivacypolicy.oopy.io/')),
        subMenuWidget(
            title: "서비스 이용약관",
            tapped: () => isWebRouter(context, 'https://arounduspp2.oopy.io/')),
        subMenuWidget(
            title: "개인정보 수집, 이용 방침",
            tapped: () =>
                isWebRouter(context, 'https://aroundusprivacypolicy.oopy.io/')),
        ListTile(
            contentPadding: EdgeInsets.all(0),
            dense: true,
            leading:
                Text('버전 정보', style: Theme.of(context).textTheme.headline5),
            trailing: Text('${_packageInfo.version}',
                style: TextStyle(color: Colors.black)))
      ])
    ]);
  }

  Column shoppingWire(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      menuWidget('shopping.'),
      SizedBox(height: 10),
      Column(children: [
        subMenuWidget(
            title: "내 쿠폰",
            tapped: () {
              if (is_authenticated) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CouponScreen(isMypage: true)));
              } else {
                showSocialLoginNeededDialog(context);
              }
            }),
        subMenuWidget(
            title: "배송지 관리",
            tapped: () {
              if (is_authenticated) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddressScreen(isOrdering: false)));
              } else {
                showSocialLoginNeededDialog(context);
              }
            }),
        subMenuWidget(
            title: "주문 내역",
            tapped: () {
              if (is_authenticated) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => OrderFormListScreen()));
              } else {
                showSocialLoginNeededDialog(context);
              }
            })
      ])
    ]);
  }

  Widget myPageInfo() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Text('WELCOME :)',
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.black)),
          const SizedBox(height: 10),
          RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.headline3,
                  children: [
                TextSpan(text: "${user.nickname}님"),
                const TextSpan(
                    text: " 반가워요!", style: TextStyle(color: Colors.black))
              ])),
          const SizedBox(height: 10)
        ]);
  }

  Future<bool> requestCameraPermission(BuildContext context) async {
    PermissionStatus status = await Permission.camera.request();

    if (!status.isGranted) {
      // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(content: const Text("권한 설정을 확인해주세요."), actions: [
              MaterialButton(
                  onPressed: () => openAppSettings(), child: const Text('설정하기'))
            ]);
          });
      return false;
    } else {
      isWebRouter(context, 'https://ed83p.channel.io');
      return true;
    }
  }
}

class loginNeededProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Text('로그인이 필요한 서비스입니다.',
              style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 20),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                  child: Container(
                      width: double.infinity,
                      child: Center(
                          child: Text('LOGIN / REGISTER',
                              style: Theme.of(context).textTheme.headline4))),
                  onTap: () => showSocialLoginNeededDialog(context))),
          SizedBox(height: 10)
        ]);
  }
}
