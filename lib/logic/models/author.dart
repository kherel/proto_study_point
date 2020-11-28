import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proto_study_point/logic/models/draft.dart';

import 'book.dart';

typedef GetBooks = List<Book> Function(String authorId);

@immutable
class Author extends Equatable {
  final String name;
  final String imagePath;
  final String id;
  final DraftObject about;

   Author({
    @required this.name,
    @required this.imagePath,
    @required this.id,
    @required this.about,
    GetBooks getBooks,
  })  : _getBooks = getBooks,
        assert(name != null),
        assert(imagePath != null),
        assert(id != null),
        assert(about != null);

  List<Object> get props => [name, imagePath, id];

  List<Book> get books => _getBooks(id);

  final GetBooks _getBooks;

  Author setGetBooks(
    List<Book> Function(String authorId) getBooks,
  ) =>
      Author(
        name: name,
        id: id,
        getBooks: getBooks,
        imagePath: imagePath,
        about: about,
      );

  bool get hasMoreBooks => books.length > 1;

  List<Book> otherBooksExcept(String id) {
    var res = [...books]..removeWhere((book) => book.id == id);
    return res;
  }
}

class SocialUrl {
  SocialUrl(this.stringUrl, this.type);
  String stringUrl;
  SocialUrlType type;

  IconData get icon {
    switch (type) {
      case SocialUrlType.youtube:
        return FontAwesomeIcons.youtube;
      case SocialUrlType.fb:
        return FontAwesomeIcons.facebook;
      case SocialUrlType.vk:
        return FontAwesomeIcons.vk;
      case SocialUrlType.instagram:
        return FontAwesomeIcons.instagram;
      case SocialUrlType.email:
        return FontAwesomeIcons.envelope;
    }
    return null;
  }
}

enum SocialUrlType { youtube, fb, vk, instagram, email }

// class Contacts {
//   String youtube = 'https://www.youtube.com/channel/UC_QUFTgPMnr722dPe1K2H3A';
// }
