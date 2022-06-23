import 'package:flutter_svg/flutter_svg.dart';
import 'package:turtlz/repositories/authentication_repository/authentication_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/modules/orderForm/view/orderForm_list_screen.dart';
import 'package:turtlz/modules/mypage/address/view/address_screen.dart';
import 'package:turtlz/modules/store/coupon/view/coupon_screen.dart';
import 'package:turtlz/support/base_component/company_info.dart';
import 'package:turtlz/support/base_component/login_needed.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as Svg;
import 'package:permission_handler/permission_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:vrouter/vrouter.dart';
import 'components/menu_widgets.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  PackageInfo _packageInfo = PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown');

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() => _packageInfo = info);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('my page.',
                                  style: Theme.of(context).textTheme.headline3),
                              IconButton(
                                  onPressed: () => state.status ==
                                          AuthenticationStatus.authenticated
                                      ? context.vRouter.toNamed('/notification')
                                      : showSocialLoginNeededDialog(context),
                                  icon: ImageIcon(
                                      Svg.Svg("assets/icons/noti.svg"),
                                      color: theme.primaryColor))
                            ]),
                        if (state.status == AuthenticationStatus.authenticated)
                          Column(
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                        children: [
                                      TextSpan(text: "${state.user.nickname}님"),
                                      const TextSpan(
                                          text: " 반가워요!",
                                          style: TextStyle(color: Colors.black))
                                    ])),
                                const SizedBox(height: 10)
                              ])
                        else
                          loginNeededProfile(),
                        Container(
                            color: Colors.white,
                            child: Column(children: [
                              const SizedBox(height: 20),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    menuWidget('shopping.'),
                                    const SizedBox(height: 10),
                                    Column(children: [
                                      subMenuWidget(
                                          icon: SvgPicture.asset(
                                              "assets/icons/coupon.svg",
                                              color: Colors.black,
                                              height: 16),
                                          title: "내 쿠폰",
                                          tapped: () {
                                            if (state.status ==
                                                AuthenticationStatus
                                                    .authenticated) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          CouponScreen(
                                                              isMypage: true)));
                                            } else {
                                              showSocialLoginNeededDialog(
                                                  context);
                                            }
                                          }),
                                      subMenuWidget(
                                          icon: SvgPicture.asset(
                                              "assets/icons/shipping.svg",
                                              color: Colors.black,
                                              height: 20),
                                          title: "배송지 관리",
                                          tapped: () {
                                            if (state.status ==
                                                AuthenticationStatus
                                                    .authenticated) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          AddressScreen(
                                                              isOrdering:
                                                                  false)));
                                            } else {
                                              showSocialLoginNeededDialog(
                                                  context);
                                            }
                                          }),
                                      subMenuWidget(
                                          icon: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 3),
                                            child: SvgPicture.asset(
                                              'assets/icons/_invoice.svg',
                                              color: Colors.black,
                                              height: 24,
                                            ),
                                          ),
                                          title: "주문 내역",
                                          tapped: () {
                                            if (state.status ==
                                                AuthenticationStatus
                                                    .authenticated) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          OrderFormListScreen()));
                                            } else {
                                              showSocialLoginNeededDialog(
                                                  context);
                                            }
                                          })
                                    ])
                                  ]),
                              const SizedBox(height: 20),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    menuWidget('account.'),
                                    const SizedBox(height: 10),
                                    Column(children: [
                                      subMenuWidget(
                                          icon: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 3),
                                            child: SvgPicture.asset(
                                                "assets/icons/1_1.svg",
                                                height: 20,
                                                color: Colors.black),
                                          ),
                                          title: "1:1 문의하기",
                                          tapped: () {
                                            requestCameraPermission(context);
                                          })
                                    ])
                                  ]),
                              const SizedBox(height: 20),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    menuWidget('service.'),
                                    const SizedBox(height: 10),
                                    Column(children: [
                                      subMenuWidget(
                                          icon: const Icon(Icons.check,
                                              color: Colors.black),
                                          title: "개인정보 처리방침",
                                          tapped: () => isWebRouter(context,
                                              'https://aroundusprivacypolicy.oopy.io/')),
                                      subMenuWidget(
                                          icon: const Icon(Icons.list,
                                              color: Colors.black),
                                          title: "서비스 이용약관",
                                          tapped: () => isWebRouter(context,
                                              'https://arounduspp2.oopy.io/')),
                                      subMenuWidget(
                                          icon: const Icon(
                                              Icons.account_circle_outlined,
                                              color: Colors.black),
                                          title: "개인정보 수집, 이용 방침",
                                          tapped: () => isWebRouter(context,
                                              'https://aroundusprivacypolicy.oopy.io/')),
                                      ListTile(
                                          leading: const Icon(
                                              Icons.approval_outlined),
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          dense: true,
                                          title: Text('버전 정보',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5),
                                          trailing: Text(_packageInfo.version,
                                              style: const TextStyle(
                                                  color: Colors.black)))
                                    ])
                                  ]),
                              const SizedBox(height: 29),
                              if (state.status ==
                                  AuthenticationStatus.authenticated)
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MaterialButton(
                                          padding: const EdgeInsets.all(10),
                                          onPressed: () => showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    title: const Text(
                                                        "로그아웃 하시겠습니까?"),
                                                    actions: [
                                                      MaterialButton(
                                                          onPressed: () {
                                                            RepositoryProvider
                                                                    .of<AuthenticationRepository>(
                                                                        context)
                                                                .logOut();
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text("확인"))
                                                    ]);
                                              }),
                                          child: Text('로그아웃',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.grey,
                                                      decoration: TextDecoration
                                                          .underline))),
                                      Container(
                                          height: 12,
                                          width: 1,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 30)),
                                      MaterialButton(
                                          padding: const EdgeInsets.all(10),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                      title:
                                                          Text("회원 탈퇴 하시겠습니까?"),
                                                      actions: [
                                                        MaterialButton(
                                                            onPressed: () {
                                                              RepositoryProvider
                                                                      .of<AuthenticationRepository>(
                                                                          context)
                                                                  .signOut();
                                                            },
                                                            child: const Text(
                                                                "확인"))
                                                      ]);
                                                });
                                          },
                                          child: Text('회원탈퇴',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.grey,
                                                      decoration: TextDecoration
                                                          .underline)))
                                    ]),
                              if (state.status ==
                                  AuthenticationStatus.authenticated)
                                const SizedBox(height: 20),
                              // CompanyInfo()
                            ]))
                      ]))));
    });
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
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                  child: SizedBox(
                      width: double.infinity,
                      child: Center(
                          child: Text('LOGIN / REGISTER',
                              style: Theme.of(context).textTheme.headline4))),
                  onTap: () => showSocialLoginNeededDialog(context))),
          const SizedBox(height: 10)
        ]);
  }
}
