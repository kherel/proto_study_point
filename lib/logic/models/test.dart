import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'draft.dart';

abstract class Test extends Equatable {
  const Test(
    this.id,
  );

  final String id;
}

abstract class SingleTest extends Test {
  const SingleTest(
    String id,
    this.rightAnswer,
  ) : super(
          id,
        );

  final Object rightAnswer;
}

abstract class MultipleTest extends Test {
  const MultipleTest(id, this.questions) : super(id);

  final List<SimpleQuizeQuestion> questions;
}

class SimpleQuize extends MultipleTest {
  SimpleQuize({
    @required String id,
    @required List<SimpleQuizeQuestion> questions,
  })  : assert(id != null),
        assert(questions != null),
        super(id, questions);

  @override
  List<Object> get props => [
        id,
        questions,
      ];
}

class SimpleQuizeQuestion {
  const SimpleQuizeQuestion({
    @required this.id,
    @required this.question,
    @required this.answers,
    @required this.rightAnswer,
  })  : assert(id != null),
        assert(question != null),
        assert(answers != null),
        assert(rightAnswer != null);

  final DraftObject question;
  final List<String> answers;
  final int rightAnswer;
  final String id;
}

class QuizeWithTextBlocks extends MultipleTest {
  QuizeWithTextBlocks({
    @required String id,
    @required List<SimpleQuizeQuestion> questions,
  })  : assert(id != null),
        assert(questions != null),
        super(id, questions);

  @override
  List<Object> get props => [
        id,
        questions,
      ];
}

class QuizeWithTextBlocksQuestion {
  const QuizeWithTextBlocksQuestion({
    @required this.id,
    @required this.question,
    @required this.answers,
  })  : assert(id != null),
        assert(question != null),
        assert(answers != null);

  final List<DraftSpan> question;
  final List<String> answers;
  final String id;
}

abstract class DraftSpan {}

class QuizeQuestionSpanData extends DraftSpan {
  final String answer;

  QuizeQuestionSpanData(this.answer);
}

class TextData extends DraftSpan {
  final String text;

  TextData(this.text);
}

class QuizeWithTextBlocksQuestionNoAnswers {
  const QuizeWithTextBlocksQuestionNoAnswers({
    @required this.id,
    @required this.question,
  })  : assert(id != null),
        assert(question != null);

  final List<DraftSpan> question;
  final String id;
}
