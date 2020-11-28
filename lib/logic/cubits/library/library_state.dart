part of 'library_cubit.dart';

class LibraryState extends Equatable {
  LibraryState(List<Book> books) {
    authors.addAll(
      allAuthors.map(
        (author) => author.setGetBooks(getBook),
      ),
    );
    books = books
        .map(
          (book) => book.setGetAuthour(
            author: authors.firstWhere((author) {
              return author.id == book.authorId;
            }),
          ),
        )
        .toList();
    this.books.addAll(books);
  }

  @override
  List<Object> get props => [...books, ...authors];

  List<Book> getBook(String authorId) {
    return books.where((book) => book.authorId == authorId).toList();
  }

  final List<Book> books = [];
  final List<Author> authors = [];

  List<Book> get mybooks => books.where((book) => book.isBought).toList();

  LibraryState updateBook(Book updatedBook) {
    var newBooks = [...books];
    var index = books.indexWhere((b) => b.id == updatedBook.id);
    newBooks[index] = updatedBook;

    return LibraryState(newBooks);
  }

  Book findBookById(String id) => books.firstWhere((book) => book.id == id);
}

List<Author> allAuthors = [
  Author(
    imagePath: 'assets/images/eugene.png',
    name: 'Max Martin',
    id: 'max_martin',
    about: DraftObject.fromJson({
      "blocks": [
        {
          "key": "an4nn",
          "text":
              "Martin has written or co-written 23 Billboard Hot 100 number-one songs, most of which he has also produced or co-produced, including Katy Perry's \"I Kissed a Girl\" (2008), Maroon 5's \"One More Night\" (2012), Taylor Swift's \"Shake It Off\" and \"Blank Space\" (2014), and The Weeknd's \"Blinding Lights\" (2019). Martin is the songwriter with the third-most number-one singles on the chart, behind only Paul McCartney (32) and John Lennon (26).[4] In addition, he is tied for the most Hot 100 number-one singles as a producer, 23, along with George Martin, who had achieved 23 by the time of his death.[5]",
          "type": "unstyled",
          "depth": 0,
          "inlineStyleRanges": [
            {"offset": 22, "length": 48, "style": "BOLD"},
            {"offset": 479, "length": 40, "style": "BOLD"},
            {"offset": 146, "length": 17, "style": "ITALIC"},
            {"offset": 183, "length": 16, "style": "ITALIC"},
            {"offset": 223, "length": 15, "style": "ITALIC"},
            {"offset": 242, "length": 20, "style": "ITALIC"},
            {"offset": 281, "length": 17, "style": "ITALIC"}
          ],
          "entityRanges": [],
          "data": {}
        },
        {
          "key": "e8io6",
          "text": "",
          "type": "unstyled",
          "depth": 0,
          "inlineStyleRanges": [],
          "entityRanges": [],
          "data": {}
        }
      ],
      "entityMap": {}
    }),
  ),
  Author(
    imagePath: 'assets/images/man.png',
    name: 'S. Johnson',
    id: 's_johnson',
    about: DraftObject.fromJson({
      "blocks": [
        {
          "key": "an4nn",
          "text":
              "Steven Berlin Johnson (born June 6, 1968) is an American popular science author and media theorist.",
          "type": "unstyled",
          "depth": 0,
          "inlineStyleRanges": [
            {"offset": 0, "length": 21, "style": "BOLD"},
            {"offset": 65, "length": 14, "style": "BOLD"},
            {"offset": 84, "length": 14, "style": "BOLD"}
          ],
          "entityRanges": [],
          "data": {}
        }
      ],
      "entityMap": {}
    }),
    // about:
    // "Steven grew up in Washington, D.C.,[2] where he attended St. Albans School. He completed his undergraduate degree at Brown University, where he studied semiotics,[3][4] a part of the school's modern culture and media department.[5] He also has a graduate degree from Columbia University in English literature.",
  ),
  Author(
    imagePath: 'assets/images/salma.png',
    name: 'Salma Hayek',
    id: 'salma_hayek',
    about: DraftObject.fromJson({
      "blocks": [
        {
          "key": "an4nn",
          "text":
              "Salma Hayek Jiménez was born in Coatzacoalcos, Veracruz, Mexico.[9] Her father, Sami Hayek Domínguez, is a Lebanese Mexican,[10] hailing from the city of Baabdat, Lebanon, a city Salma and her father visited in 2015 to promote her movie Kahlil Gibran's The Prophet. He owns an industrial-equipment firm and is an oil company executive in Mexico,[9] who once ran for mayor of Coatzacoalcos.[15][16] Her mother, Diana Jiménez Medina, is an opera singer and talent scout, and is a Mexican of Spanish descent. In an interview in 2015 with Un Nuevo Día while visiting Madrid, Hayek described herself as fifty-percent Lebanese and fifty-percent Spanish, stating that her grandmother/maternal great-grandparents were from Spain. Her younger brother, Sami (born 1972), is a furniture designer.[9]",
          "type": "unstyled",
          "depth": 0,
          "inlineStyleRanges": [
            {"offset": 0, "length": 11, "style": "BOLD"},
            {"offset": 338, "length": 6, "style": "BOLD"},
            {"offset": 410, "length": 20, "style": "BOLD"},
            {"offset": 478, "length": 26, "style": "BOLD"},
            {"offset": 639, "length": 7, "style": "BOLD"},
            {"offset": 715, "length": 5, "style": "BOLD"},
            {"offset": 79, "length": 21, "style": "ITALIC"}
          ],
          "entityRanges": [],
          "data": {}
        }
      ],
      "entityMap": {}
    }),
  ),
];
