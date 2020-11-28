import 'package:flutter/material.dart';
import 'package:proto_study_point/ui/pages/library/library.dart';
import 'package:proto_study_point/utils/navigator.dart';
import 'package:proto_study_point/utils/shrink_utils.dart';

class HeaderSliver extends StatelessWidget {
  const HeaderSliver({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: HeaderSliverDelegate(),
      floating: true,
      pinned: true,
    );
  }
}

class A extends SliverAppBar {}

class HeaderSliverDelegate extends SliverPersistentHeaderDelegate
    with ShrinkMixin {
  @override
  Widget build(context, double shrinkOffset, overlapsContent) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Text('Kherel'),
          Spacer(),
          IconButton(
            icon: Icon(Icons.library_books),
            onPressed: push(context, page: LibraryPage()),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => {},
          ),
        ],
      ),
    );
  }

  double get maxExtent => 100;

  @override
  double get minExtent => 76;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
