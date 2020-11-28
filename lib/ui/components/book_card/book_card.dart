import 'package:flutter/material.dart';
import 'package:proto_study_point/logic/models/book.dart';
import 'package:proto_study_point/ui/components/book_cart_info/book_cart_info.dart';
import 'package:proto_study_point/ui/pages/book/book.dart';
import 'package:proto_study_point/ui/route_transitions/slide_bottom.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    Key key,
    @required this.book,
    this.showBought = false,
  }) : super(key: key);

  final Book book;
  final bool showBought;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: InkResponse(
        onTap: () => Navigator.of(context).push(
          SlideBottomRoute(
            BookPage(
              bookData: book,
            ),
          ),
        ),
        child: Card(
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BookCartInfo(bookData: book),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    book.isBought || book.progress != 0
                        ? Text('Progress: ${book.progress} %')
                        : Container(),
                    Spacer(),
                    book.isBought
                        ? showBought
                            ? RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                  children: [
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                    ),
                                    TextSpan(text: 'Bought'),
                                  ],
                                ),
                              )
                            : Container()
                        : Text('Price: ${book.price.toString()} \$'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
