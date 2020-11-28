import 'package:flutter/material.dart';
import 'package:proto_study_point/logic/models/book.dart';

class BookCartInfo extends StatelessWidget {
  const BookCartInfo({
    Key key,
    @required this.bookData,
  }) : super(key: key);
  final Book bookData;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
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
        SizedBox(width: 10),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 118,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookData.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    Text('by ${bookData.author.name}'),
                    Spacer(),
                    Text('Level: ${bookData.level}'),
                    Row(
                      children: [
                        Text('Units: ${bookData.unitCount}'),
                        SizedBox(width: 10),
                        Text('Exercises: ${bookData.exerciseCount}'),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 2),
      ],
    );
  }
}
