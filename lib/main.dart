// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proto_study_point/logic/models/draft.dart';
import 'package:proto_study_point/ui/components/draft_view/draft_view.dart';
import 'package:proto_study_point/ui/pages/main/main.dart';
import 'config/bloc_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: BlocConfig(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          home: MainPageScreen(),
        ),
      ),
    );
  }
}

class Test extends StatelessWidget {
  const Test({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var draftObject = DraftObject.fromJson({
      "blocks": [
        {
          "key": "4rvho",
          "text": "11222333",
          "type": "unstyled",
          "depth": 0,
          "inlineStyleRanges": [
            {"offset": 2, "length": 3, "style": "BOLD"}
          ],
          "entityRanges": [],
          "data": {}
        }
      ],
      "entityMap": {}
    });
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...DraftView.list(draftObject),
              DraftToFlutter(
                draftObject,
                ValueKey('11'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
