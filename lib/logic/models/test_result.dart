import 'package:equatable/equatable.dart';

abstract class TestResult extends Equatable {
  TestResult(this.id);

  final String id;

  bool get isPassed;
}

class SingleTestResult extends TestResult {
  SingleTestResult(
    String id,
    this.rightAnswer, [
    this.answer,
  ]) : super(id);

  final Object rightAnswer;
  final Object answer;

  bool get isPassed => rightAnswer != null && rightAnswer == answer;

  SingleTestResult copyWith(Object answer) => SingleTestResult(
        id,
        rightAnswer,
        answer,
      );

  @override
  List<Object> get props => [id, rightAnswer, answer];
}

class MultipleTestResult extends TestResult {
  MultipleTestResult(
    String id,
    this.resultList,
  ) : super(id);

  final List<SingleTestResult> resultList;

  bool get isPassed => resultList.every((element) => element.isPassed);

  @override
  List<Object> get props => [id, ...resultList];
}
