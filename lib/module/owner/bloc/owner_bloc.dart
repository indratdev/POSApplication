import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/model/profile_model.dart';
import 'package:posapplication/module/owner/owner_profile/controller/profile_controller.dart';

part 'owner_event.dart';
part 'owner_state.dart';

class OwnerBloc extends Bloc<OwnerEvent, OwnerState> {
  OwnerBloc() : super(OwnerInitial()) {
    final ProfileController controller = ProfileController();

    on<AddProfileCompanyEvent>((event, emit) async {
      emit(LoadingAddProfileCompany());
      try {
        var profileData = event.profileModel;
        var result = await controller.addProfileCompany(profileData);
        result.fold(
          (l) => emit(FailureAddProfileCompany(messageError: l)),
          (data) => emit(SuccessAddProfileCompany(status: data)),
        );
      } catch (e) {
        print(e.toString());
        emit(FailureAddProfileCompany(messageError: e.toString()));
      }
    });
  }
}
