import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:proto_study_point/logic/models/author.dart';
import 'package:proto_study_point/logic/models/section.dart';
import 'package:proto_study_point/logic/models/test.dart';
import 'package:proto_study_point/logic/models/test_result.dart';
import 'package:proto_study_point/logic/models/unit.dart';

abstract class BookData extends Equatable {
  final String imagePath;
  final String title;
  final String level;
  final String theme;
  final double price;
  final String authorId;
  final Author author;
  final bool isBought;
  final String id;
  final List<Section> sections;
  final Map<String, TestResult> results;

  BookData({
    @required this.id,
    @required this.imagePath,
    @required this.title,
    @required this.level,
    @required this.theme,
    @required this.authorId,
    @required this.price,
    @required this.sections,
    @required this.isBought,
    this.author,
    Map<String, TestResult> results,
  })  : results = results ?? BookData._emptyResults(sections),
        assert(id != null),
        assert(imagePath != null),
        assert(title != null),
        assert(level != null),
        assert(theme != null),
        assert(authorId != null),
        assert(price != null),
        assert(sections != null),
        assert(isBought != null);

  static Map<String, TestResult> _emptyResults(List<Section> sections) {
    var results = <String, TestResult>{};
    var units = <Unit>[];
    for (var section in sections) {
      if (section is UnitSection) {
        units.addAll(section.units);
      }
    }

    for (var unit in units) {
      for (var test in unit.tests) {
        if (test is SingleTest) {
          results[test.id] = SingleTestResult(test.id, test.rightAnswer);
        } else if (test is MultipleTest) {
          var listResults = test.questions
              .map((question) => SingleTestResult(
                    question.id,
                    question.rightAnswer,
                  ))
              .toList();
          results[test.id] = MultipleTestResult(test.id, listResults);
        } else {
          assert(test is! SingleTest && test is! MultipleTest);
        }
      }
    }
    return results;
  }

  @override
  List<Object> get props => [
        author,
        authorId,
        title,
        imagePath,
        level,
        theme,
        price,
        isBought,
        id,
        ...sections,
        results
      ];

  @override
  String toString() {
    return title;
  }
}

class Book extends BookData with BookHelpers {
  Book({
    @required String id,
    @required String imagePath,
    @required String title,
    @required String level,
    @required String theme,
    @required String authorId,
    @required double price,
    @required List<Section> sections,
    bool isBought = false,
    Author author,
    Map<String, TestResult> results,
  }) : super(
          id: id,
          imagePath: imagePath,
          title: title,
          level: level,
          theme: theme,
          authorId: authorId,
          price: price,
          sections: sections,
          isBought: isBought,
          author: author,
          results: results,
        );

  Book setGetAuthour({
    Author author,
  }) {
    return Book(
      author: author,
      authorId: authorId,
      title: title,
      imagePath: imagePath,
      level: level,
      theme: theme,
      price: price,
      isBought: isBought,
      id: id,
      sections: sections,
      results: results,
    );
  }

  Book copyWith({
    bool isBought,
    Map<String, TestResult> results,
  }) {
    return Book(
      author: author,
      authorId: authorId,
      title: title,
      imagePath: imagePath,
      level: level,
      theme: theme,
      price: price,
      isBought: isBought ?? this.isBought,
      id: id,
      sections: sections,
      results: results ?? this.results,
    );
  }
}

mixin BookHelpers on BookData {
  int get exerciseCount => results.values.length;
  int get unitCount => sections.length;

  double get progress {
    if (exerciseCount == 0) return 100.0;
    var answeredNumber = results.values.fold(
        0,
        (dynamic previousValue, element) =>
            previousValue + (element.isPassed ? 1 : 0));

    return answeredNumber / exerciseCount * 100;
  }

  List<Book> get otherBooks {
    return author.otherBooksExcept(id);
  }
}
