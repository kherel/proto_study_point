part of 'user_cubit.dart';

class UserState extends Equatable {
  final List<Book> books;

  UserState({
    this.currentBookIndex = 0,
    this.books = const [],
  });

  final int currentBookIndex;

  Book get currentBook => books[currentBookIndex];

  UserState copyWith({
    currentBookIndex,
    books,
  }) =>
      UserState(
        books: books ?? this.books,
        currentBookIndex: currentBookIndex ?? this.currentBookIndex,
      );

  @override
  List<Object> get props => [books, currentBookIndex];
}
