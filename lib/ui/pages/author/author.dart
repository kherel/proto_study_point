import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proto_study_point/config/text_styles.dart';
import 'package:proto_study_point/logic/models/author.dart';
import 'package:proto_study_point/ui/components/book_card/book_card.dart';
import 'package:proto_study_point/ui/components/draft_view/draft_view.dart';
import 'package:proto_study_point/ui/components/youtube/youtube.dart';

class AuthorPage extends StatelessWidget {
  const AuthorPage({
    Key key,
    @required this.author,
  }) : super(key: key);

  final Author author;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(author.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Hero(
              tag: author.id,
              child: Image.asset(
                author.imagePath,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(height: 10),
            Text(
              author.name,
              style: BrandTextStyles.h1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            DraftToFlutter(author.about, ValueKey('about')),
            Youtube(url: 'https://www.youtube.com/watch?v=6vtaIwn88hQ'),
            SizedBox(height: 20),
            Text(
              'Books',
              style: BrandTextStyles.h2,
              textAlign: TextAlign.center,
            ),
            ...author.books.map(
              (bookData) => BookCard(
                book: bookData,
                showBought: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
