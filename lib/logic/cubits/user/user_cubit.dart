import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proto_study_point/logic/models/book.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());
}
