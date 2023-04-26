import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/domain/export.dart';

import '../../../data/model/profile_model.dart';

part 'owner_event.dart';
part 'owner_state.dart';

class OwnerBloc extends Bloc<OwnerEvent, OwnerState> {
  final OwnerRepository ownerRepository = OwnerRepository();

  OwnerBloc() : super(OwnerInitial()) {
    // final ProfileController controller = ProfileController();
    final OwnerRepository ownerRepository = OwnerRepository();

    on<AddProfileCompanyEvent>((event, emit) async {
      emit(LoadingAddProfileCompany());
      try {
        var profileData = event.profileModel;
        var result = await ownerRepository.addProfileCompany(profileData);
        result.fold(
          (l) => emit(FailureAddProfileCompany(messageError: l)),
          (data) => emit(SuccessAddProfileCompany(dataProfile: data)),
        );
      } catch (e) {
        print(e.toString());
        emit(FailureAddProfileCompany(messageError: e.toString()));
      }
    });

    // update
    on<UpdateProfileCompanyEvent>((event, emit) async {
      emit(LoadingUpdateProfileCompany());
      try {
        var profileData = event.profileModel;
        var result = await ownerRepository.addProfileCompany(profileData);
        result.fold(
          (l) => emit(FailureUpdateProfileCompany(messageError: l)),
          (data) => emit(SuccessUpdateProfileCompany(dataProfile: data)),
        );
      } catch (e) {
        print(e.toString());
        emit(FailureUpdateProfileCompany(messageError: e.toString()));
      }
    });

    // check profile and firebase
    on<CheckProfileBoxAndFirebaseEvent>((event, emit) async {
      try {
        await ownerRepository.checkProfileBoxAndFirebase();
      } catch (e) {
        log(e.toString());
      }
    });

    // open box profile
    on<OpenBoxProfileEvent>((event, emit) async {
      emit(LoadingOpenBoxProfileCompany());
      try {
        print("runnnn OpenBoxProfileEvent ...");
        Box resultBox;
        resultBox = await ownerRepository.isBoxProfileAlreadyOpen();

        // if empty, check from firebase
        if (resultBox.isEmpty) {
          print(">>> check from firebase");
          // read profile company
          await ownerRepository.readProfileCompany();
          // read box again after read from firebase
          resultBox = await ownerRepository.isBoxProfileAlreadyOpen();
        }
        // print(resultBox.values.first);
        emit(SuccessOpenBoxProfileCompany(dataBox: resultBox));
      } catch (e) {
        log(e.toString());
        emit(FailureOpenBoxProfileCompany(messageError: e.toString()));
      }
    });

    // logout
    on<LogoutEvent>((event, emit) {
      try {
        ownerRepository.logout();
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
