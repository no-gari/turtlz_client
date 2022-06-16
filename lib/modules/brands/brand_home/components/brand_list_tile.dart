import 'package:turtlz/modules/brands/brand_detail/view/brand_detail_screen.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';

class BrandListTile extends StatelessWidget {
  BrandListTile(
      {@required this.Id,
      @required this.name,
      @required this.description,
      @required this.logo});

  final String? Id, name, description, logo;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: Adaptive.h(0.5)),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: () => Navigator.pushNamed(
                context, BrandDetailScreen.routeName,
                arguments: {'Id': this.Id}),
            leading: Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(this.logo!),
                    radius: 20)),
            title: Text(this.name!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.w700)),
            subtitle: Text(this.description!,
                style: Theme.of(context).textTheme.bodyText2,
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
            isThreeLine: true));
  }
}
