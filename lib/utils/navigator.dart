import 'package:flutter/widgets.dart';
import 'package:proto_study_point/ui/route_transitions/basic.dart';

void Function() push(
  BuildContext context, {
  @required Widget page,
  Route route,
}) {
  if (route != null) {
    return () => Navigator.of(context).push(route);
  }
  return () => Navigator.of(context).push(
        noAnimationRoute(
          page,
        ),
      );
}
