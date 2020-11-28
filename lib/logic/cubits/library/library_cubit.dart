import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proto_study_point/logic/models/author.dart';
import 'package:proto_study_point/logic/models/book.dart';
import 'package:proto_study_point/logic/models/draft.dart';
import 'package:proto_study_point/logic/models/section.dart';
import 'package:proto_study_point/logic/models/test.dart';
import 'package:proto_study_point/logic/models/test_result.dart';
import 'package:proto_study_point/logic/models/unit.dart';
import 'package:shortuuid/shortuuid.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit() : super(LibraryState(initBooks));

  void buy(String id) {
    var book = state.findBookById(id);
    var updatedBook = book.copyWith(isBought: true);
    var newState = state.updateBook(updatedBook);
    emit(newState);
  }

  void answer(String bookId, String testId, answer, [String questionId]) {
    var book = state.findBookById(bookId);
    var updatedResults = {...book.results};

    var res = updatedResults[testId];
    if (res is MultipleTestResult) {
      var list = [...res.resultList];
      var lastRes = list.firstWhere((element) => element.id == questionId);
      var newRes = lastRes.copyWith(answer);
      list.removeWhere((element) => element.id == questionId);
      list.add(newRes);
      var newTestRes = MultipleTestResult(testId, list);
      updatedResults[testId] = newTestRes;
      var updatedBook = book.copyWith(results: updatedResults);
      var newState = state.updateBook(updatedBook);
      emit(newState);
    } else {
      var newRes = (res as SingleTestResult).copyWith(answer);
      updatedResults[bookId] = newRes;
      book.copyWith(results: updatedResults);
      var newState = state.updateBook(book);
      emit(newState);
    }
  }
}

final List<Book> initBooks = [
  Book(
    imagePath: 'assets/images/book1.png',
    title: 'English Grammar for beginers',
    level: 'A0-A1',
    theme: 'English',
    price: 6.9,
    authorId: 'max_martin',
    id: ShortUuid.shortv4(),
    sections: [
      InfoSection(
        body: DraftObject.fromJson({
          "blocks": [
            {
              "key": "ccii4",
              "text":
                  "When it comes to English speaking skills, you should not pay too much attention to grammar rules at first. However, this does not mean that we should ignore English grammar completely.",
              "type": "unstyled",
              "depth": 0,
              "inlineStyleRanges": [],
              "entityRanges": [],
              "data": {}
            },
            {
              "key": "1ui7t",
              "text":
                  "Needless to say, basic English grammar rules play an important role in learning English, both written and spoken. Without grammar rules, you can sometimes make yourself understood with short and simple expressions. However, you may fail most of the time with more complicated expressions that require the correct orders or structures of words.",
              "type": "unstyled",
              "depth": 0,
              "inlineStyleRanges": [
                {"offset": 17, "length": 27, "style": "BOLD"}
              ],
              "entityRanges": [],
              "data": {}
            }
          ],
          "entityMap": {}
        }),
        title: 'Description',
      ),
      InfoSection(
        body: DraftObject.fromJson(
          {
            "blocks": [
              {
                "key": "7lcu2",
                "text":
                    "As a beginner, you must know basic English grammar rules, as they show you how to arrange vocabulary and make meaningful expressions.",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [],
                "entityRanges": [],
                "data": {}
              },
              {
                "key": "8ep1g",
                "text":
                    "Below is a series of 40 basic English grammar lessons covering most of the English grammar tenses and most-used structures. All the lessons are designed with clear definitions, explanations and forms, followed by lots of examples.",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [
                  {"offset": 21, "length": 32, "style": "BOLD"},
                  {"offset": 63, "length": 59, "style": "BOLD"}
                ],
                "entityRanges": [],
                "data": {}
              },
              {
                "key": "e1gph",
                "text":
                    "Don’t try to learn by heart all the forms without doing any meaningful training. What you really need to do is take advantage of all the English grammar practice through sample sentences – in other words, you must understand how to use each rule and apply it to your daily speech.",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [
                  {"offset": 162, "length": 24, "style": "ITALIC"},
                  {"offset": 214, "length": 65, "style": "BOLD"}
                ],
                "entityRanges": [],
                "data": {}
              }
            ],
            "entityMap": {}
          },
        ),
        title: 'Who is this book for?',
      ),
    ],
  ),
  Book(
    imagePath: 'assets/images/book3.png',
    title: 'English as a Second F*cking Language',
    level: 'B1-B2',
    theme: 'English',
    price: 10.9,
    authorId: 's_johnson',
    id: ShortUuid.shortv4(),
    sections: [
      InfoSection(
        body: DraftObject.fromJson(
          {
            "blocks": [
              {
                "key": "an4nn",
                "text":
                    "In the English language, swearing is essential to effective communication. In this hilarious and illuminating guide, you will learn just how to do it - no f*cking problem.",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [
                  {"offset": 0, "length": 171, "style": "BOLD"}
                ],
                "entityRanges": [],
                "data": {}
              },
            ],
            "entityMap": {}
          },
        ),
        title: 'Description',
      ),
    ],
  ),
  Book(
    imagePath: 'assets/images/book2.png',
    title: 'Mexican Spanish',
    level: 'A1-A2',
    theme: 'Spanish',
    price: 7.0,
    authorId: 'salma_hayek',
    id: ShortUuid.shortv4(),
    sections: [
      InfoSection(
        body: DraftObject.fromJson(
          {
            "blocks": [
              {
                "key": "81c47",
                "text":
                    "La Gramática básica del estudiante de español (GBE) es una gramática pedagógica de autoaprendizaje para estudiantes de los niveles A1-B1 del Marco de Referencia Europeo. En ella se abordan los aspectos gramaticales más problemáticos del español mediante explicaciones fáciles y claras, seguidas de ejercicios variados, amenos y útiles. Concebida para el aprendizaje autónomo del estudiante, puede usarse sin la ayuda del profesor o como complemento a cursos de lengua, también de niveles superiores al B1. Ofrece explicaciones claras, precisas y rigurosas en un lenguaje fácil y comprensible. Contiene más de 470 ilustraciones que ayudan a entender los aspectos gramaticales tratados. Con más de 370 ejercicios para comprender y asimilar las formas gramaticales, así como para evitar los errores más frecuentes. Con muestras de lengua y ejemplos representativos del uso comunicativo real del español y con una variada tipología de textos. Incluye también: Soluciones a los ejercicios Tablas de verbos regulares e irregulares conjugados Completo índice temático de fácil manejo",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [
                  {"offset": 0, "length": 51, "style": "BOLD"},
                  {"offset": 131, "length": 38, "style": "BOLD"},
                  {"offset": 696, "length": 66, "style": "BOLD"},
                  {"offset": 336, "length": 169, "style": "UNDERLINE"}
                ],
                "entityRanges": [],
                "data": {}
              }
            ],
            "entityMap": {}
          },
        ),
        title: 'Description',
      ),
    ],
  ),
  Book(
    imagePath: 'assets/images/book2.png',
    title: 'English Grammar',
    level: 'A2',
    theme: 'English',
    price: 3.9,
    authorId: 'max_martin',
    isBought: true,
    id: ShortUuid.shortv4(),
    sections: [
      InfoSection(
        body: DraftObject.fromJson(
          {
            "blocks": [
              {
                "key": "1hhi3",
                "text":
                    "Do you feel that it’s “like pulling teeth” when you want to learn new sayings?",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [
                  {"offset": 0, "length": 78, "style": "BOLD"}
                ],
                "entityRanges": [],
                "data": {}
              },
              {
                "key": "6uu7r",
                "text":
                    "Would you like to be able to discover new American idioms and phrases that will make communication “a piece of cake”?",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [
                  {"offset": 0, "length": 117, "style": "BOLD"}
                ],
                "entityRanges": [],
                "data": {}
              },
              {
                "key": "2s28f",
                "text": "",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [],
                "entityRanges": [],
                "data": {}
              },
              {
                "key": "bigon",
                "text":
                    "Sure, you can learn English with a language course or a textbook just fine, and climb up the ranks in terms of your grasp of the language… but are you sure you can talk like a native?",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [],
                "entityRanges": [],
                "data": {}
              },
              {
                "key": "3brtr",
                "text":
                    "For starters, many expressions used by fluent speakers of English can’t exactly be learned in a book, and it can be frustrating to realize that your formal learning hasn’t been enough to teach you the way people talk in real life. ",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [],
                "entityRanges": [],
                "data": {}
              },
              {
                "key": "17qre",
                "text":
                    "Sometimes, it’s all about having the right tools at your disposal… and this is where The Great Book of American Idioms comes in!",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [],
                "entityRanges": [],
                "data": {}
              },
              {
                "key": "2imvi",
                "text":
                    "Written to act as a powerful addition to your other English-learning resources, this book will allow you to:",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [],
                "entityRanges": [],
                "data": {}
              },
              {
                "key": "avgv7",
                "text":
                    "Discover over 1300 different idioms and sayings, covering hundreds of different subjects",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [
                  {"offset": 0, "length": 88, "style": "BOLD"}
                ],
                "entityRanges": [],
                "data": {}
              },
              {
                "key": "i7fn",
                "text":
                    "Learn the correct definition and usage of each expression, ensuring that you know exactly when you can say them out loud during a conversation",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [],
                "entityRanges": [],
                "data": {}
              },
              {
                "key": "9hvfg",
                "text":
                    "Visualize examples of the sayings in common conversations, helping you understand their context",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [],
                "entityRanges": [],
                "data": {}
              },
              {
                "key": "d3k10",
                "text":
                    "Take advantage of important tips we provide you in the introduction and conclusion of the book, so that you can boost your learning and get a much better understanding of the English language.",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [],
                "entityRanges": [],
                "data": {}
              },
              {
                "key": "e49rr",
                "text":
                    "What are you waiting for? Over 1300 idioms and expressions are awaiting you! Don’t miss out on learning why this “dark horse” will help you “see the big picture”!",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [
                  {"offset": 77, "length": 85, "style": "ITALIC"}
                ],
                "entityRanges": [],
                "data": {}
              },
            ],
            "entityMap": {}
          },
        ),
        title: 'Description',
      ),
      InfoSection(
        body: DraftObject.fromJson({
          "blocks": [
            {
              "key": "1hhi3",
              "text":
                  "It’s not meant to be read straight through, like a novel or a class curriculum. This is meant to be an active reference—a book you can flip through to find useful guidance on specific topics when you need some perspective or advice.",
              "type": "unstyled",
              "depth": 0,
              "inlineStyleRanges": [
                {"offset": 0, "length": 80, "style": "BOLD"}
              ],
              "entityRanges": [],
              "data": {}
            },
            {
              "key": "ef0qt",
              "text":
                  "I’ve included many interviews from entrepreneurs with proven track records. Although I have worked at some of the fastest growing companies in Silicon Valley history, my experience is far from exhaustive. Sometimes it just helps to have different perspectives. I’m honored to include these experts’ perspectives, even when—especially when—it doesn’t jibe completely with my own. You might find it fun to skip between interviews and read one after the other—there are some great stories and valuable advice embedded within.",
              "type": "unstyled",
              "depth": 0,
              "inlineStyleRanges": [],
              "entityRanges": [],
              "data": {}
            },
            {
              "key": "e150m",
              "text":
                  "When there are online references that might prove useful, I’ve included a footnote pointing to my website, where you can find more direct links to these resources.",
              "type": "unstyled",
              "depth": 0,
              "inlineStyleRanges": [],
              "entityRanges": [],
              "data": {}
            },
          ],
          "entityMap": {}
        }),
        title: 'How to use this book',
      ),
      UnitSection(
        title: 'Past and Present',
        units: [
          Unit(
            title: 'Unit 1: Diferencia entre HAVE and HAVE GOT',
            body: DraftObject.fromJson(
              {
                "blocks": [
                  {
                    "key": "d0mvr",
                    "text": "Diferencia entre HAVE and HAVE GOT - Very simple!",
                    "type": "heading2",
                    "depth": 0,
                    "inlineStyleRanges": [],
                    "entityRanges": [],
                    "data": {}
                  },
                  {
                    "key": "3qntv",
                    "text":
                        "En esta oportunidad, comprenderás la diferencia de HAVE y HAVE GOT. Es muy sencillo. Te invito para que veas cómo utilizarlos y decide cuándo usarlos.   En esta oportunidad, veremos algunas diferencias notables que tienen estas dos palabras, ya que seguramente has escuchado la una y la otra en inglés.   Es por eso que he realizado este video, para ayudarte a comprender, muy fácilmente, cada una de ellas. Así que comencemos.",
                    "type": "unstyled",
                    "depth": 0,
                    "inlineStyleRanges": [
                      {"offset": 21, "length": 46, "style": "BOLD"}
                    ],
                    "entityRanges": [],
                    "data": {}
                  },
                  {
                    "key": "52djs",
                    "text": "",
                    "type": "atomic",
                    "depth": 0,
                    "inlineStyleRanges": [],
                    "entityRanges": [],
                    "data": {
                      "url": "assets/images/from_now.png",
                      "subType": "image"
                    }
                  },
                  {
                    "key": "4rvho",
                    "text": "Quiz test boldFont italic example",
                    "type": "testLink",
                    "depth": 0,
                    "inlineStyleRanges": [
                      {"offset": 10, "length": 8, "style": "BOLD"},
                      {"offset": 19, "length": 6, "style": "ITALIC"}
                    ],
                    "entityRanges": [],
                    "data": {'id': '4rvhoTest'}
                  },
                  {
                    "key": "9kn7r",
                    "text": "",
                    "type": "atomic",
                    "depth": 0,
                    "inlineStyleRanges": [],
                    "entityRanges": [],
                    "data": {"url": "assets/images/now.png", "subType": "image"}
                  }
                ],
                "entityMap": {}
              },
            ),
            tests: [
              SimpleQuize(
                id: '4rvhoTest',
                questions: [
                  SimpleQuizeQuestion(
                    question: DraftObject.fromJson(
                      {
                        "blocks": [
                          {
                            "key": "4rvho",
                            "text": "¿Cómo se escribe este número  1.631.503?",
                            "type": "unstyled",
                            "depth": 0,
                            "inlineStyleRanges": [
                              {"offset": 0, "length": 40, "style": "BOLD"}
                            ],
                            "entityRanges": [],
                            "data": {}
                          },
                          {
                            "key": "92bgt",
                            "text": "Elige la respuesta correcta",
                            "type": "unstyled",
                            "depth": 0,
                            "inlineStyleRanges": [],
                            "entityRanges": [],
                            "data": {}
                          },
                        ],
                        "entityMap": {}
                      },
                    ),
                    id: ShortUuid.shortv4(),
                    answers: [
                      'Uno miliones seiscentos treinta y un mil quinientos tres',
                      'Un millón seiscientos treinta y un mil quinientos tres',
                      'Un millón seiscientos treinta mil e quinientos tres',
                      'Un millón setecientos treinta y un mil quinientos tres'
                    ],
                    rightAnswer: 1,
                  ),
                  SimpleQuizeQuestion(
                    question: DraftObject.fromJson({
                      "blocks": [
                        {
                          "key": "f52bd",
                          "text": "",
                          "type": "atomic",
                          "depth": 0,
                          "inlineStyleRanges": [],
                          "entityRanges": [],
                          "data": {
                            "url": "assets/images/chica.jpg",
                            "subType": "image"
                          }
                        },
                        {
                          "key": "b72ei",
                          "text":
                              "¿Cómo es esta chica? Elige la respuesta correcta *",
                          "type": "unstyled",
                          "depth": 0,
                          "inlineStyleRanges": [],
                          "entityRanges": [],
                          "data": {}
                        }
                      ],
                      "entityMap": {}
                    }),
                    id: ShortUuid.shortv4(),
                    answers: [
                      'Es una chica delgada y alta. Tiene el pelo largo y ondulado. Lleva sombrero y gafas de ver.',
                      'Es una chica delgada y alta. Tiene el pelo rubio y largo. Lleva gorra y gafas de sol.',
                      'Es una chica delgada y bajita. Tiene el pelo largo y muy rizado. Lleva gorro y gafas de ver.',
                      'Es una chica delgada y alta. Tiene el pelo corto y ondulado. Lleva una pulsera y un collar.'
                    ],
                    rightAnswer: 0,
                  ),
                ],
              ),
            ],
          ),
          Unit(
            title: 'Испанские местоимения',
            body: DraftObject.fromJson(
              {
                "entityMap": {},
                "blocks": [
                  {
                    "key": "c33j5",
                    "text": "",
                    "type": "atomic",
                    "depth": 0,
                    "inlineStyleRanges": [],
                    "entityRanges": [],
                    "data": {
                      "url": "https://www.youtube.com/watch?v=hR-_ocRDby4",
                      "subType": "youtube"
                    }
                  },
                  {
                    "key": "311pf",
                    "text":
                        "В первом уроке мы изучим испанские местоимения: Yo, tú, él, ella, usted, nosotros, vosotros, ellos, ustedes. Местоимения используются вместо имени существительного. Не забывайте, что у некоторых местоимений необходимо ставить acento!",
                    "type": "unstyled",
                    "depth": 0,
                    "inlineStyleRanges": [
                      {"offset": 48, "length": 10, "style": "BOLD"}
                    ],
                    "entityRanges": [],
                    "data": {}
                  },
                ],
              },
            ),
          ),
        ],
      ),
    ],
  )
];
