import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:proto_study_point/logic/models/draft.dart';

import 'unit.dart';

abstract class Section extends Equatable {
  Section(this.title);

  final String title;
}

class UnitSection extends Section {
  UnitSection({
    @required String title,
    @required this.units,
  })  : assert(title != null),
        assert(units != null),
        super(title);

  final List<Unit> units;

  @override
  List<Object> get props => [title, ...units];
}

class InfoSection extends Section {
  InfoSection({
    @required this.body,
    @required String title,
  })  : assert(title != null),
        assert(body != null),
        super(title);

  final DraftObject body;

  @override
  List<Object> get props => [
        title,
        body,
      ];
}
