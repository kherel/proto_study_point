import 'dart:math';

import 'package:flutter/material.dart';
import 'package:proto_study_point/ui/components/brand_divider/brand_divider.dart';

class Accordion extends StatefulWidget {
  const Accordion({
    Key key,
    @required this.title,
    @required this.child,
    this.padding,
  }) : super(key: key);

  final String title;
  final Widget child;
  final EdgeInsets padding;
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _heightFactor;
  Animation _colorTween;

  bool _isExpanded = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {});
        });
      }
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(
        milliseconds: 150,
      ),
      vsync: this,
    );
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeIn));
    _colorTween = ColorTween(
      begin: Colors.grey,
      end: Colors.black87,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller.view,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BrandDivider(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: widget.padding.copyWith(top: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          widget.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Transform.rotate(
                        angle: pi * _heightFactor.value * 0.5,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: _colorTween.value,
                        ),
                      )
                    ],
                  ),
                ),
                onTap: _handleTap,
              ),
              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  heightFactor: _heightFactor.value,
                  child: widget.child,
                ),
              ),
            ],
          );
        });
  }
}
