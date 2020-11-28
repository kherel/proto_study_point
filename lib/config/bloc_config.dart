import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proto_study_point/logic/cubits/library/library_cubit.dart';

class BlocConfig extends StatelessWidget {
  const BlocConfig({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LibraryCubit>(
          create: (context) => LibraryCubit(),
        ),
      ],
      child: child,
    );
  }
}
