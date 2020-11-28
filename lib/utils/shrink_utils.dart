import 'package:flutter/widgets.dart';

mixin ShrinkMixin on SliverPersistentHeaderDelegate {
  double get delta => maxExtent - minExtent;

  double srinkRate(shrinkOffset) => (shrinkOffset / delta).clamp(0, 1);
}
