import 'package:flutter/material.dart';
import 'package:proto_study_point/logic/cubits/library/library_cubit.dart';
import 'package:proto_study_point/logic/models/test.dart';
import 'package:proto_study_point/logic/models/test_result.dart';
import 'package:proto_study_point/ui/components/draft_view/draft_view.dart';
import 'package:proto_study_point/ui/components/exercise_bottom_bar/exercise_bottom_bar.dart';

class SimpleQuizePage extends StatefulWidget {
  SimpleQuizePage({
    Key key,
    @required this.title,
    @required this.test,
    @required this.bookId,
  })  : assert(title != null),
        assert(test != null),
        super(key: key);

  final Widget title;
  final SimpleQuize test;
  final String bookId;

  @override
  _SimpleQuizePageState createState() => _SimpleQuizePageState();
}

class _SimpleQuizePageState extends State<SimpleQuizePage> {
  PageController controller = PageController();

  bool showAnswer = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pageCount = widget.test.questions.length;
    final LibraryCubit library = context.watch<LibraryCubit>();

    final LibraryState libraryState = library.state;
    final book = libraryState.findBookById(widget.bookId);

    var res = book.results[widget.test.id] as MultipleTestResult;

    return Scaffold(
      appBar: AppBar(
        title: widget.title,
      ),
      body: PageView.builder(
        controller: controller,
        itemBuilder: (context, pageIndex) {
          var question = widget.test.questions[pageIndex];
          var answers = question.answers;
          var prevAnswer =
              res.resultList.firstWhere((res) => res.id == question.id).answer;

          return LayoutBuilder(builder: (context, constraites) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraites.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: DraftView.list(question.question),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Question: ${pageIndex + 1} / $pageCount',
                          textAlign: TextAlign.center,
                        ),
                        ...answers
                            .asMap()
                            .map(
                              (index, answer) => MapEntry(
                                index,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  child: RaisedButton(
                                    color: prevAnswer == index
                                        ? showAnswer
                                            ? question.rightAnswer == index
                                                ? Colors.green
                                                : Colors.red
                                            : Colors.blue
                                        : showAnswer
                                            ? question.rightAnswer == index
                                                ? Colors.green
                                                : Colors.grey
                                            : Colors.grey,
                                    onPressed: () {
                                      library.answer(
                                        widget.bookId,
                                        widget.test.id,
                                        index,
                                        question.id,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(answer),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .values
                            .toList(),
                        SizedBox(height: 10),
                        ExersiseBottomBar(
                          controller: controller,
                          pageIndex: pageIndex,
                          pageCount: pageCount,
                          showAnswer: () => setState(
                            () {
                              showAnswer = true;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        },
        itemCount: pageCount,
      ),
    );
  }
}
