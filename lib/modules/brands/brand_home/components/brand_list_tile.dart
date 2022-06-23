import 'package:turtlz/modules/brands/brand_detail/view/brand_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class BrandListTile extends StatelessWidget {
  BrandListTile({@required this.Id, @required this.name, @required this.logo});

  final String? Id, name, logo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () => context.vRouter.toNamed(BrandDetailScreen.routeName,
            pathParameters: {'brandId': this.Id!}),
        leading: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(this.logo!),
                radius: 20)),
        title: Text(this.name!,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w700)),
        trailing:
            const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 15));
  }
}
