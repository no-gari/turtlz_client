import 'package:turtlz/modules/brands/brand_detail/view/brand_detail_screen.dart';
import 'package:flutter/material.dart';

class BrandListTile extends StatelessWidget {
  BrandListTile({@required this.Id, @required this.name, @required this.logo});

  final String? Id, name, logo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BrandDetailScreen(brandId: this.Id))),
        title: Text(this.name!, style: Theme.of(context).textTheme.headline5),
        trailing:
            const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 15));
  }
}
