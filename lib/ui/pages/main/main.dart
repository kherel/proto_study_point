import 'package:flutter/material.dart';
import 'package:proto_study_point/logic/cubits/library/library_cubit.dart';
import 'package:proto_study_point/ui/components/book_card/book_card.dart';
import 'package:proto_study_point/ui/components/header_sliver/header_sliver.dart';

class MainPageScreen extends StatelessWidget {
  const MainPageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({
    Key key,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final LibraryState libraryState = context.watch<LibraryCubit>().state;
    return NestedScrollView(
      headerSliverBuilder: (_, __) => [HeaderSliver()],
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Text(
              'My Library',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            ...libraryState.mybooks.map(
              (book) => BookCard(
                book: book,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
