import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/model/users_model.dart';
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
        List<UsersModel> result = await userDashboardController.readAllUser();

        emit(SuccessGetAllUser(resultModel: result));
      } catch (e) {
        emit(FailureGetAllUser(messageError: e.toString()));
        print(e.toString());
      }
    });
  }
}
