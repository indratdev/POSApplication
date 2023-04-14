import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/module/Users/user_dashboard/controller/user_dashboard_controller.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserDashboardController userDashboardController =
      UserDashboardController();
  UsersBloc() : super(UsersInitial()) {
    on<GetAllUsersEvent>((event, emit) async {
      emit(LoadingGetAllUser());
      try {
        var aaa = await userDashboardController.getAllUser();
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
