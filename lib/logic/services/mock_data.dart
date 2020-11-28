// import 'package:proto_study_point/logic/models/author.dart';
// import 'package:proto_study_point/logic/models/book.dart';

// class MockData {
//   static List<Book> books = [
//     Book(
//       author: authors[0],
//       imagePath: 'assets/images/book1.png',
//       title: 'English Grammar for beginers',
//       level: 'A0-A1',
//       unitCount: 30,
//       exerciseCount: 96,
//       theme: 'English',
//       price: 6.9,
//     ),
//     Book(
//       author: authors[1],
//       imagePath: 'assets/images/book3.png',
//       title: 'English as a Second F*cking Language',
//       level: 'B1-B2',
//       unitCount: 100,
//       exerciseCount: 40,
//       theme: 'English',
//       price: 10.9,
//     ),
//     Book(
//       author: authors[2],
//       imagePath: 'assets/images/book2.png',
//       title: 'Mexican Spanish',
//       level: 'A1-A2',
//       unitCount: 10,
//       exerciseCount: 50,
//       theme: 'Spanish',
//       price: 7.0,
//     ),
//     Book(
//       author: authors[0],
//       imagePath: 'assets/images/book2.png',
//       title: 'English Grammar',
//       level: 'A2',
//       unitCount: 10,
//       exerciseCount: 50,
//       theme: 'English',
//       price: 3.9,
//     ),
//   ];

//   static List<Author> authors = [
//     Author(
//       imagePath: 'assets/images/eugene.png',
//       name: 'Eugene Fedorov',
//       getBooks: getBook,
//     ),
//     Author(
//       imagePath: 'assets/images/man.png',
//       name: 'S. Johnson',
//       getBooks: getBook,
//     ),
//     Author(
//       imagePath: 'assets/images/salma.png',
//       name: 'Salma Hayek',
//       getBooks: getBook,
//     ),
//   ];

//   static List<Book> getBook(Author author) {
//     return books.where((book) => book.author == author).toList();
//   }
// }
