import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:proto_study_point/config/text_styles.dart';
import 'package:proto_study_point/logic/cubits/library/library_cubit.dart';
import 'package:proto_study_point/logic/models/book.dart';
import 'package:proto_study_point/logic/models/section.dart';
import 'package:proto_study_point/logic/models/unit.dart';
import 'package:proto_study_point/ui/components/accordion/accordion.dart';
import 'package:proto_study_point/ui/components/draft_view/draft_view.dart';
import 'package:proto_study_point/ui/pages/author/author.dart';
import 'package:proto_study_point/ui/pages/section/section.dart';
import 'package:proto_study_point/ui/route_transitions/basic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proto_study_point/ui/route_transitions/slide_bottom.dart';

const padding = EdgeInsets.fromLTRB(15, 0, 15, 0);

class BookPage extends StatelessWidget {
  const BookPage({
    Key key,
    @required this.bookData,
  }) : super(key: key);

  final Book bookData;

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryCubit>();
    final book = library.state.findBookById(bookData.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(bookData.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Hero(
            tag: bookData.id,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 118,
                minHeight: 118,
              ),
              child: Image.asset(
                bookData.imagePath,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: BrandTextStyles.h3,
                      ),
                      Text(
                        book.theme,
                        style: BrandTextStyles.descritpion,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    book.isBought
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : RaisedButton(
                            onPressed: () => library.buy(book.id),
                            child: Text('Buy: ${book.price} \$'),
                          ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    materialRoute(
                      AuthorPage(author: book.author),
                    ),
                  ),
                  child: Hero(
                    tag: bookData.author.id,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 100,
                        minHeight: 100,
                      ),
                      child: Image.asset(
                        bookData.author.imagePath,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Author'),
                        Text(bookData.author.name),
                        if (bookData.author.hasMoreBooks) ...[
                          Text('Other book of this author:'),
                          ...bookData.otherBooks
                              .map(
                                (book) => GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                    materialRoute(
                                      BookPage(
                                        bookData: book,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    book.title,
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(
            'Content',
            textAlign: TextAlign.center,
            style: BrandTextStyles.h2,
          ),
          SizedBox(height: 20),
          ...book.sections
              .map(
                (section) => Accordion(
                  title: section.title,
                  padding: padding,
                  child: section is UnitSection
                      ? _CardColumn(
                          units: section.units,
                          bookId: bookData.id,
                        )
                      : Padding(
                          padding: padding.copyWith(bottom: 20),
                          child: DraftToFlutter(
                            (section as InfoSection).body,
                            ValueKey(
                                (section as InfoSection).body.blocks[0].key),
                          ),
                        ),
                ),
              )
              .toList(),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

class _CardColumn extends StatelessWidget {
  const _CardColumn({
    Key key,
    this.units,
    @required this.bookId,
  }) : super(key: key);

  final List<Unit> units;
  final String bookId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: units
          .map(
            (unit) => InkWell(
              onTap: () => Navigator.of(context).push(
                SlideBottomRoute(
                  SectionPage(unit: unit, bookId: bookId),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Hero(
                  tag: unit.title,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      unit.title,
                      style: BrandTextStyles.h3,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
