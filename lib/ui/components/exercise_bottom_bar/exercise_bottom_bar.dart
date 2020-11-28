import 'package:flutter/material.dart';

class ExersiseBottomBar extends StatelessWidget {
  const ExersiseBottomBar({
    Key key,
    this.controller,
    this.pageIndex,
    this.pageCount,
    this.showAnswer,
  }) : super(key: key);

  final PageController controller;
  final int pageIndex;
  final int pageCount;
  final void Function() showAnswer;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        bottom: true,
        child: Row(
          children: [
            _Buttom(
              onTap: pageIndex > 0
                  ? () => controller.previousPage(
                        duration: Duration(microseconds: 200),
                        curve: Curves.ease,
                      )
                  : null,
              text: 'back',
            ),
            Spacer(),
            _Buttom(onTap: showAnswer, text: 'show'),
            Spacer(),
            _Buttom(
              onTap: pageIndex + 1 < pageCount
                  ? () => controller.nextPage(
                        duration: Duration(microseconds: 200),
                        curve: Curves.ease,
                      )
                  : null,
              text: 'forward',
            ),
          ],
        ),
      ),
    );
  }
}

class _Buttom extends StatelessWidget {
  const _Buttom({
    Key key,
    this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueAccent,
          ),
        ),
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: SafeArea(
          bottom: true,
          child: Text(text),
        ),
      ),
    );
  }
}
