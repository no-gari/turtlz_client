import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextField(
          textInputAction: TextInputAction.search,
          autofocus: true,
          controller: _textEditingController,
          decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintText: '브랜드 혹은 상품을 입력하세요.',
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                color: Colors.black,
                onPressed: () => _textEditingController.clear(),
              ))),
      SizedBox(height: 30),
      Text('최근 검색어', style: Theme.of(context).textTheme.headline4)
    ]);
  }
}
