import 'package:turtlz/repositories/product_repository/models/product.dart';
import 'package:turtlz/repositories/product_repository/models/models.dart';
import 'package:turtlz/repositories/cart_repository/models/cart_temp.dart';
import 'package:turtlz/modules/store/product/cubit/product_cubit.dart';
import 'package:turtlz/repositories/cart_repository/models/cart.dart';
import 'package:turtlz/modules/store/order/view/order_screen.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ProductPurchaseSheet extends StatefulWidget {
  @override
  _ProductPurchaseSheetState createState() => _ProductPurchaseSheetState();
}

class _ProductPurchaseSheetState extends State<ProductPurchaseSheet> {
  AppsflyerSdk appsflyerSdk = AppsflyerSdk(AppsFlyerOptions(
      afDevKey: 'k9PJxiGCC9TFE4humtAzbb', appId: '1632376048'));
  static final facebookAppEvents = FacebookAppEvents();
  late ProductCubit _productCubit;
  late Product _product;
  late double modalHeight;

  @override
  void initState() {
    super.initState();
    _productCubit = BlocProvider.of<ProductCubit>(context);
    _product = _productCubit.state.products!.first;

    // 각 옵션의 variant의 개수가 가장 많은 것을 기준으로 option expanded widget height 계산
    var optionsVariantList =
        _product.options!.map((e) => e.variations!.length.toInt()).toList();
    var maxVariantsCount = optionsVariantList.reduce(max);
    modalHeight = (maxVariantsCount) * 8 + 35;
  }

  /*
  selectedOptions : 사용자가 선택한 옵션
  - 옵션 조합마다 Id값이 유니크해서, type씩 맵핑해줘야함
  quantity : 구매할 옵션의 수량
  */
  late List<TypeGroup> selectedOptions = List.generate(
      _product.options!.length,
      (index) => TypeGroup(
          option: Option(
              Id: _product.options![index].Id,
              name: _product.options![index].name)));

  int selected = 0;
  bool hasCart = false;
  List<CartTemp> cartTempList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
        builder: (context, comments) {
      hasCart = !selectedOptions
          .map((e) => e.variation != null)
          .toList()
          .contains(false);

      return Container(
          height: maxHeight(context) - 150,
          padding: const EdgeInsets.only(top: 30),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  hasCart
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOptions = List.generate(
                                  _product.options!.length, (index) {
                                return TypeGroup(
                                    option: Option(
                                        Id: _product.options![index].Id,
                                        name: _product.options![index].name));
                              });
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    color: Colors.white),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("옵션을 선택해주세요",
                                          style: TextStyle(
                                              color: Colors.grey[600])),
                                      const Icon(
                                          Icons.keyboard_arrow_down_sharp)
                                    ])),
                          ))
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Wrap(
                              runSpacing: 5,
                              children: optionPurchase(_product.options!))),
                  hasCart
                      ? ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ListTile(
                                    shape: const RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.grey)),
                                    minVerticalPadding: 5,
                                    title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  "${cartTempList[index].variants!.variantName}",
                                                  style:
                                                      theme.textTheme.headline5,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
                                          IconButton(
                                              padding: EdgeInsets.zero,
                                              alignment: Alignment.centerRight,
                                              icon: const Icon(Icons.clear),
                                              onPressed: () {
                                                if (index == 0 &&
                                                    cartTempList.length == 1) {
                                                  setState(() {
                                                    cartTempList = [];
                                                    selectedOptions = List.generate(
                                                        _product
                                                            .options!.length,
                                                        (index) => TypeGroup(
                                                            option: Option(
                                                                Id: _product
                                                                    .options![
                                                                        index]
                                                                    .Id,
                                                                name: _product
                                                                    .options![
                                                                        index]
                                                                    .name)));
                                                  });
                                                } else {
                                                  setState(() {
                                                    cartTempList
                                                        .removeAt(index);
                                                  });
                                                }
                                              })
                                        ]),
                                    subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              height: 30,
                                              margin:
                                                  const EdgeInsets.only(top: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        iconSize: 15,
                                                        icon: const Icon(
                                                            Icons.remove),
                                                        onPressed: () {
                                                          setState(() {
                                                            if (cartTempList[
                                                                        index]
                                                                    .quantity! >
                                                                1) {
                                                              cartTempList[
                                                                  index] = cartTempList[
                                                                      index]
                                                                  .copyWith(
                                                                      quantity:
                                                                          cartTempList[index].quantity! -
                                                                              1);
                                                            }
                                                          });
                                                        }),
                                                    Text(
                                                        "${cartTempList[index].quantity}"),
                                                    IconButton(
                                                        iconSize: 15,
                                                        icon: const Icon(
                                                            Icons.add),
                                                        onPressed: () {
                                                          setState(() {
                                                            if (cartTempList[
                                                                        index]
                                                                    .quantity! <
                                                                100) {
                                                              cartTempList[
                                                                  index] = cartTempList[
                                                                      index]
                                                                  .copyWith(
                                                                      quantity:
                                                                          cartTempList[index].quantity! +
                                                                              1);
                                                            }
                                                          });
                                                        })
                                                  ])),
                                          Text(
                                              currencyFromString(
                                                  (cartTempList[index]
                                                              .variants!
                                                              .discountPrice! *
                                                          cartTempList[index]
                                                              .quantity!)
                                                      .toString()),
                                              style: theme.textTheme.headline5)
                                        ])));
                          },
                          itemCount: cartTempList.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 10))
                      : const SizedBox(height: 0),
                  if (cartTempList.isNotEmpty) purchaseSummary(),
                  SizedBox(
                      height: 70,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  if (cartTempList.isNotEmpty) {
                                    _productCubit.createCard(
                                        _product, cartTempList);
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              title: Text("장바구니에 상품이 담겼습니다."),
                                              actions: [
                                                MaterialButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("확인"))
                                              ]);
                                        });
                                    for (var cart in cartTempList) {
                                      facebookAppEvents.logAddToCart(
                                          id: _product.Id!,
                                          type: cart.variants!.Id!,
                                          price: cart.variants!.discountPrice!
                                              .toDouble(),
                                          currency: 'KRW');
                                      appsflyerSdk.logEvent('af_add_to_cart', {
                                        'af_price':
                                            cart.variants!.discountPrice!,
                                        'af_content':
                                            cart.variants!.variantName,
                                        'af_content_id': _product.Id,
                                        'af_content_type': cart.variants!.Id,
                                        'af_currency': 'KRW',
                                        'af_quantity': cart.quantity
                                      });
                                    }
                                  } else {
                                    chooseProduct(context);
                                  }
                                },
                                child: Container(
                                    width: (maxWidth(context) - 50) / 2,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: theme.primaryColor),
                                        color: Colors.white),
                                    child: Text("장바구니 담기",
                                        style: theme.textTheme.headline5!
                                            .copyWith(
                                                color: theme.primaryColor)))),
                            const SizedBox(width: 10),
                            GestureDetector(
                                onTap: () {
                                  List<Cart> carts = cartTempList
                                      .map((c) => Cart(
                                            brand: _product.brand!.name,
                                            productId: _product.Id,
                                            productName: _product.name,
                                            productThumbnail:
                                                _product.thumbnail,
                                            variantId: c.variants!.Id!,
                                            variantName:
                                                c.variants!.variantName,
                                            salePrice:
                                                c.variants!.discountPrice,
                                            quantity: c.quantity,
                                          ))
                                      .toList();

                                  if (cartTempList.isNotEmpty) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrderScreen(carts)));
                                  } else {
                                    chooseProduct(context);
                                  }
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    width: (maxWidth(context) - 50) / 2,
                                    alignment: Alignment.center,
                                    child: Text("구매하기",
                                        style: theme.textTheme.button!
                                            .copyWith(color: Colors.white))))
                          ]))
                ]),
          ));
    });
  }

  void chooseProduct(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: const Text("상품을 선택해주세요."), actions: [
            MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("확인"))
          ]);
        });
  }

  List<Widget> optionPurchase(List<Option> options) {
    return List.generate(
        options.length,
        (i) => Card(
              child: ExpansionTile(
                  key: GlobalKey(),
                  title: RichText(
                      text:
                          TextSpan(style: theme.textTheme.headline5, children: [
                    TextSpan(text: "${options[i].name}"),
                    TextSpan(
                        text: selectedOptions[i].variation == null
                            ? ""
                            : selectedOptions[i].variation!.value)
                  ])),
                  initiallyExpanded: i == selected,
                  children: ListTile.divideTiles(
                      color: Colors.grey[200],
                      tiles:
                          List.generate(options[i].variations!.length, (index) {
                        bool available = true;

                        for (int k = 0; k < _product.variants!.length; k++) {
                          _product.variants![k].types!.forEach((element) {
                            if (element.variation!.Id ==
                                    options[i].variations![index].Id &&
                                _product.variants![k].available == false) {
                              available = !available;
                            }
                          });
                          if (available == false) {
                            break;
                          }
                        }

                        return ListTile(
                            title: available
                                ? Text(options[i].variations![index].value)
                                : Text(
                                    "${options[i].variations![index].value} (품절)",
                                    style: TextStyle(color: Colors.grey)),
                            onTap: () {
                              // 선택 옵션 추가
                              if (available) {
                                setState(() {
                                  selectedOptions[i] = selectedOptions[i]
                                      .copyWith(
                                          variation:
                                              options[i].variations![index]);
                                  selected = selected + 1;
                                });

                                if (!selectedOptions
                                    .map((e) => e.variation != null)
                                    .toList()
                                    .contains(false)) {
                                  // cartTemp 생성

                                  Variants? variant;

                                  _product.variants!.forEach((element) {
                                    if (listEquals(
                                        element.types, selectedOptions)) {
                                      variant = element;
                                    }
                                  });

                                  bool generated = false;
                                  // 이미 생성되어 있는 경우
                                  cartTempList.forEach((element) {
                                    if (listEquals(element.variants!.types,
                                        selectedOptions)) {
                                      index = cartTempList.indexOf(element);
                                      setState(() {
                                        generated = true;
                                        cartTempList[index] =
                                            cartTempList[index].copyWith(
                                                quantity: cartTempList[index]
                                                        .quantity! +
                                                    1);
                                      });
                                    }
                                  });

                                  if (!generated) {
                                    setState(() {
                                      selected = 0;
                                      cartTempList.add(CartTemp(
                                          variants: variant, quantity: 1));
                                    });
                                  }
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          title: const Text("품절된 옵션입니다."),
                                          actions: [
                                            MaterialButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("확인"))
                                          ]);
                                    });
                              }
                            });
                      })).toList()),
            ));
  }

  Widget purchaseSummary() {
    num total = cartTempList.fold(
        0,
        (pre, cartTemp) =>
            pre + (cartTemp.quantity! * cartTemp.variants!.discountPrice!));

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: theme.dividerColor),
                )),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("총 ${cartTempList.length}개의 상품"),
                  RichText(
                      text:
                          TextSpan(style: theme.textTheme.bodyText1, children: [
                    const TextSpan(text: "총 금액 "),
                    TextSpan(
                        text: currencyFromString(total.toString()),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red))
                  ]))
                ])));
  }

  List<Widget> productQuantity() {
    return [
      Card(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [const Text("수량")]))
    ];
  }
}
