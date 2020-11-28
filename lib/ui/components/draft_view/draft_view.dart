import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proto_study_point/logic/models/draft.dart';
import 'package:proto_study_point/ui/components/youtube/youtube.dart';

import 'package:url_launcher/url_launcher.dart';

class DraftToFlutter extends StatelessWidget {
  final DraftObject draftObject;

  const DraftToFlutter(
    this.draftObject,
    Key key,
  ) : super(key: key);

  _launchURL(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  List<InlineSpan> getTextSpans() {
    final list = <InlineSpan>[];
    for (var block in draftObject.blocks) {
      if (block.type == BlockType.atomic) {
        switch (block.subtype) {
          case AtomicSubtype.image:
            list.add(
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Image.asset(
                    block.data['url'],
                  ),
                ),
              ),
            );
            break;
          case AtomicSubtype.youtube:
            list.add(
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Youtube(
                    url: block.data['url'],
                  ),
                ),
              ),
            );
            break;
          case AtomicSubtype.video:
            // TODO: Handle this case.
            break;
          case AtomicSubtype.audio:
            // TODO: Handle this case.
            break;
        }
      } else {
        int textLength = block.text != null ? block.text.runes.length : 0;
        for (int textIndex = 0; textIndex < textLength; textIndex++) {
          Color textColor = Colors.black;
          FontWeight textFontWeight = FontWeight.normal;
          FontStyle textFontStyle = FontStyle.normal;
          TextDecoration decoration = TextDecoration.none;

          TapGestureRecognizer recognizer;
          for (int inlineStyleIndex = 0;
              inlineStyleIndex < block.inlineStyleRanges.length;
              inlineStyleIndex++) {
            if (block.inlineStyleRanges[inlineStyleIndex].contains(textIndex)) {
              switch (block.inlineStyleRanges[inlineStyleIndex].style) {
                case "BOLD":
                  textFontWeight = FontWeight.bold;
                  break;
                case "ITALIC":
                  textFontStyle = FontStyle.italic;
                  break;
                case "UNDERLINE":
                  decoration = TextDecoration.underline;
                  break;
                case "STRIKETHROUGH":
                  decoration = TextDecoration.lineThrough;
                  break;
              }
            }
          }

          for (var entityRange in block.entityRanges) {
            if (entityRange.contains(textIndex)) {
              // links
              textColor = Colors.blue;
              recognizer = TapGestureRecognizer()
                ..onTap = () {
                  String key = entityRange.key.toString();
                  EntityMap entityMap = draftObject.entityMap[key];
                  _launchURL(entityMap.data.url);
                };
            }
          }
          var style = TextStyle(
            color: textColor,
            fontSize: 16,
            fontStyle: textFontStyle,
            fontWeight: textFontWeight,
            decoration: decoration,
          );
          switch (block.type) {
            case BlockType.unstyled:
              // TODO: Handle this case.
              break;
            case BlockType.heading1:
              // TODO: Handle this case.
              break;
            case BlockType.heading2:
              style = style.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              );
              break;
            case BlockType.heading3:
              // TODO: Handle this case.
              break;
            case BlockType.quote:
              // TODO: Handle this case.
              break;
            case BlockType.callout:
              // TODO: Handle this case.
              break;
            case BlockType.atomic:
              // TODO: Handle this case.
              break;
            case BlockType.unorderedListItem:
              // TODO: Handle this case.
              break;
            case BlockType.testLink:
              // TODO: Handle this case.
              break;
            case BlockType.textTestLink:
              // TODO: Handle this case.
              break;
          }
          list.add(
            TextSpan(
              text: String.fromCharCode(block.text.runes.toList()[textIndex]),
              recognizer: recognizer,
              style: style,
            ),
          );
        }
      }

      list.add(TextSpan(
        text: " \n",
      ));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: getTextSpans(),
      ),
    );
  }
}

class DraftView {
  static void _launchURL(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  static List<Widget> list(DraftObject draftObject,
      [void Function() Function(Widget title, String id) handleTest,
      Color Function(String id) getColor]) {
    final list = <Widget>[];
    for (var block in draftObject.blocks) {
      Widget widget;
      EdgeInsets padding = EdgeInsets.only(top: 10);

      switch (block.type) {
        case BlockType.atomic:
          widget = _atomicBlock(block);
          break;
        case BlockType.quote:
          widget = _textBlock(block, draftObject.entityMap);
          break;
        case BlockType.testLink:
          widget = GestureDetector(
            onTap: handleTest(
              _textBlock(
                block,
                draftObject.entityMap,
                fontSize: 18,
                fontColor: Colors.white,
              ),
              block.data['id'],
            ),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.arrowCircleRight),
                SizedBox(width: 10),
                Expanded(child: _textBlock(block, draftObject.entityMap)),
                SizedBox(width: 10),
                Icon(FontAwesomeIcons.checkCircle, color: getColor(block.data['id'])),
              ],
            ),
          );
          break;
        case BlockType.callout:
          widget = _textBlock(block, draftObject.entityMap);
          break;
        case BlockType.unstyled:
          widget = _textBlock(block, draftObject.entityMap);
          break;
        case BlockType.heading1:
          padding = padding.copyWith(bottom: 20);
          widget = _textBlock(
            block,
            draftObject.entityMap,
            fontSize: 24,
          );

          break;
        case BlockType.heading2:
          padding = padding.copyWith(bottom: 10);

          widget = _textBlock(
            block,
            draftObject.entityMap,
            textFontWeight: FontWeight.w500,
            fontSize: 20,
          );

          break;
        case BlockType.heading3:
          widget = _textBlock(
            block,
            draftObject.entityMap,
            fontSize: 18,
            textFontWeight: FontWeight.w400,
          );

          break;

        case BlockType.unorderedListItem:
          // TODO: Handle this case.
          break;
        case BlockType.textTestLink:
          // TODO: Handle this case.
          break;
      }
      if (padding != null) {
        widget = Padding(padding: padding, child: widget);
      }
      list.add(widget);
    }

    return list;
  }

  static Widget _atomicBlock(
    DraftBlock block,
  ) {
    switch (block.subtype) {
      case AtomicSubtype.image:
        return Image.asset(block.data['url']);
      case AtomicSubtype.youtube:
        return Youtube(url: block.data['url']);
      case AtomicSubtype.video:
        // TODO: Handle this case.
        break;
      case AtomicSubtype.audio:
        // TODO: Handle this case.
        break;
    }

    return null;
  }

  static Widget _textBlock(
    DraftBlock block,
    Map<String, EntityMap> entityMap, {
    TextDecoration decoration = TextDecoration.none,
    double fontSize = 16,
    FontWeight textFontWeight = FontWeight.normal,
    Color fontColor = Colors.black,
  }) {
    int textLength = block.text != null ? block.text.runes.length : 0;

    var spans = <TextSpan>[];
    for (int textIndex = 0; textIndex < textLength; textIndex++) {
      FontWeight spanFontWeight = textFontWeight;
      Color textColor = fontColor;

      FontStyle textFontStyle;
      TapGestureRecognizer recognizer;
      for (int inlineStyleIndex = 0;
          inlineStyleIndex < block.inlineStyleRanges.length;
          inlineStyleIndex++) {
        if (block.inlineStyleRanges[inlineStyleIndex].contains(textIndex)) {
          switch (block.inlineStyleRanges[inlineStyleIndex].style) {
            case "BOLD":
              spanFontWeight = FontWeight.bold;
              break;
            case "ITALIC":
              textFontStyle = FontStyle.italic;
              break;
            case "UNDERLINE":
              decoration = TextDecoration.underline;
              break;
            case "STRIKETHROUGH":
              decoration = TextDecoration.lineThrough;
              break;
          }
        }
      }

      for (var entityRange in block.entityRanges) {
        if (entityRange.contains(textIndex)) {
          // links
          textColor = Colors.blue;
          recognizer = TapGestureRecognizer()
            ..onTap = () {
              String key = entityRange.key.toString();
              EntityMap entity = entityMap[key];
              _launchURL(entity.data.url);
            };
        }
      }
      var style = TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontStyle: textFontStyle,
        fontWeight: spanFontWeight,
        decoration: decoration,
      );

      spans.add(
        TextSpan(
          text: String.fromCharCode(block.text.runes.toList()[textIndex]),
          recognizer: recognizer,
          style: style,
        ),
      );
    }

    return RichText(
      text: TextSpan(
        children: spans,
      ),
    );
  }
}
