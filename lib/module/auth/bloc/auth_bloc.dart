import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterRestoEvent>((event, emit) {
      emit(LoadingRegisterResto());
      try {} catch (e) {
        emit(FailureRegisterResto(messageError: e.toString()));
      }
    });
  }
}
