import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proto_study_point/logic/cubits/library/library_cubit.dart';
import 'package:proto_study_point/logic/models/test.dart';
import 'package:proto_study_point/logic/models/unit.dart';
import 'package:proto_study_point/ui/components/draft_view/draft_view.dart';
import 'package:proto_study_point/ui/components/text_test/text_test.dart';
import 'package:proto_study_point/ui/pages/simple_quiz/simple_quiz.dart';
import 'package:proto_study_point/ui/route_transitions/slide_right.dart';

class SectionPage extends StatelessWidget {
  const SectionPage({
    Key key,
    @required this.unit,
    @required this.bookId,
  })  : assert(unit != null),
        super(key: key);

  final Unit unit;
  final String bookId;

  @override
  Widget build(BuildContext context) {
    final LibraryCubit library = context.watch<LibraryCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: unit.title,
          child: Material(
            color: Colors.transparent,
            child: Text(
              unit.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          bottom: 15.0,
        ),
        child: ListView(
          children: [
            ...DraftView.list(
              unit.body,
              (Widget title, String id) => () {
                var test = unit.testById(id);

                if (test is SimpleQuize) {
                  Navigator.of(context).push(
                    SlideRightRoute(
                      SimpleQuizePage(title: title, test: test, bookId: bookId),
                    ),
                  );
                }
              },
              (String id) {
                var book =
                    library.state.books.firstWhere((book) => book.id == bookId);
                var res = book.results[id];
                return res.isPassed ? Colors.green : Colors.grey;
              },
            ),
            if (unit.title == 'Испанские местоимения')
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    SlideRightRoute(
                      TextTest(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.arrowCircleRight),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text('String test'),
                    ),
                    SizedBox(width: 10),
                    Icon(FontAwesomeIcons.checkCircle, color: Colors.grey),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
