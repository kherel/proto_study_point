import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:proto_study_point/logic/models/draft.dart';

import 'test.dart';

class Unit extends Equatable {
  Unit({
    @required this.body,
    @required this.title,
    this.tests = const [],
  })  : assert(title != null),
        assert(body != null),
        assert(tests != null);

  final String title;
  final DraftObject body;
  final List<Test> tests;

  Test testById(String id) => tests.firstWhere((test) => test.id == id);

  @override
  List<Object> get props => [title, body, ...tests];
}
