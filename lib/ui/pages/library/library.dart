import 'package:flutter/material.dart';
import 'package:proto_study_point/logic/cubits/library/library_cubit.dart';
import 'package:proto_study_point/logic/models/author.dart';
import 'package:proto_study_point/logic/models/book.dart';
import 'package:proto_study_point/ui/components/book_card/book_card.dart';
import 'package:proto_study_point/ui/pages/author/author.dart';
import 'package:proto_study_point/ui/route_transitions/basic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryPage extends StatefulWidget {
  LibraryPage({Key key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    final LibraryState libraryState = context.watch<LibraryCubit>().state;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Store'),
            bottom: TabBar(
              tabs: [
                Tab(child: Text('Books')),
                Tab(child: Text('Authors')),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _Books(books: libraryState.books),
              _Authors(authors: libraryState.authors),
            ],
          )),
    );
  }
}

class _Authors extends StatelessWidget {
  const _Authors({Key key, @required this.authors}) : super(key: key);

  final List<Author> authors;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      itemCount: authors.length,
      itemBuilder: (context, index) {
        var author = authors[index];
        return _AuthorCard(author: author);
      },
    );
  }
}

class _Books extends StatelessWidget {
  const _Books({Key key, this.books}) : super(key: key);
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: books.length,
      itemBuilder: (context, index) {
        var book = books[index];
        return BookCard(book: book, showBought: true);
      },
    );
  }
}

class _AuthorCard extends StatelessWidget {
  const _AuthorCard({
    Key key,
    @required this.author,
  }) : super(key: key);

  final Author author;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3, left: 20, right: 20, bottom: 15),
      child: InkResponse(
        onTap: () => Navigator.of(context).push(
          materialRoute(
            AuthorPage(
              author: author,
            ),
          ),
        ),
        child: Card(
          elevation: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 118,
                  minHeight: 118,
                ),
                child: Image.asset(
                  author.imagePath,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 118,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(author.name),
                        Text('books: ${author.books.length}'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
