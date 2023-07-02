import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/service/hive_service/hive_service.dart';
import 'package:posapplication/data/service/user_service/user_service.dart';
import 'package:posapplication/domain/export.dart';
import 'package:posapplication/domain/hive_repository.dart';
import 'package:posapplication/domain/user_repository.dart';

import '../../../data/model/users_model.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository userRepository = UserRepository();
  final UserService userService = UserService();
  final AuthRepository authRepository = AuthRepository();
  final HiveRepository hiveRepository = HiveRepository();

  UsersBloc() : super(UsersInitial()) {
    on<GetAllUsersEvent>((event, emit) async {
      emit(LoadingGetAllUser());
      try {
        List<UsersModel> result = await userRepository.readAllUser();

        emit(SuccessGetAllUser(resultModel: result));
      } catch (e) {
        log(e.toString());
        emit(FailureGetAllUser(messageError: e.toString()));
      }
    });

    on<GetAllUsersFromFirebaseEvent>((event, emit) async {
      print(">>> GetAllUsersFromFirebaseEvent runningggg....");
      emit(LoadingGetAllUserFromFirebase());
      try {
        List<UsersModel> userList = await userRepository.readAllUser();
        print(">>> length userList : ${userList.length}");

        // insert user
        await hiveRepository.deleteUsersBox(); // hapus users box dulu
        await hiveRepository.createUserFromFirebaseToHive(userList);

        //// get all users from box
        // List<UsersModel> result = await hiveRepository.readAllUsersFromHive();

        var result = await HiveService().readAllUserFromBox();
        print(">>> setelah crate baru : ${result.length}");

        emit(SuccessGetAllUserFromFirebase(resultModel: result));
      } catch (e) {
        log(e.toString());
        emit(FailureGetAllUserFromFirebase(messageError: e.toString()));
      }
    });

    on<GetAllUsersFromBoxEvent>((event, emit) async {
      emit(LoadingGetAllUserFromBox());
      try {
        // List<UsersModel> result = await userRepository.readAllUser();
        var result = await HiveService().readAllUserFromBox();
        print(">>>> result GetAllUsersEvent2 : $result");

        emit(SuccessGetAllUserFromBox(resultModel: result));
      } catch (e) {
        log(e.toString());
        emit(FailureGetAllUserFromBox(messageError: e.toString()));
      }
    });

    // add new user
    on<AddNewUsersEvent>((event, emit) async {
      try {
        emit(LoadingAddNewUser());
        print("jalan");
        String companyID = await userRepository.readCompanyID();
        UsersModel data = event.userModel;
        // daftarin emailnya dulu
        User? dataUser = await authRepository.addNewUser(data);
        if (dataUser != null) {
          // insert data auth user ke users collection
          Either<String, String> result =
              await userRepository.createNewUser(dataUser, data, companyID);
          result.fold((l) => emit(FailureAddNewUser(messageError: l)),
              (r) => emit(SuccessAddNewUser(result: r)));
        }
      } catch (e) {
        log(e.toString());
        emit(FailureAddNewUser(messageError: e.toString()));
      }
    });

    // update user
    on<UpdateUsersEvent>((event, emit) async {
      emit(LoadingUpdateUser());
      try {
        // insert data auth user ke users collection
        Either<String, String> result =
            await userRepository.updateUser(event.userModel);
        result.fold((l) => emit(FailureUpdateUser(messageError: l.toString())),
            (r) => emit(SuccessUpdateUser(result: r)));
      } catch (e) {
        log(e.toString());
        emit(FailureUpdateUser(messageError: e.toString()));
      }
    });

    // delete user
    on<deleteUsersEvent>((event, emit) async {
      emit(LoadingDeleteUser());
      try {
        // // insert data auth user ke users collection
        Either<String, String> result =
            await userRepository.deleteUser(event.documentID);
        result.fold((l) => emit(FailureDeleteUser(messageError: l.toString())),
            (r) => emit(SuccessDeleteUser(result: r)));
      } catch (e) {
        log(e.toString());
        emit(FailureDeleteUser(messageError: e.toString()));
      }
    });

    // selected user
    on<selectedUserEvent>((event, emit) {
      emit(LoadingSelectedUser());
      try {
        emit(SuccessSelectedUser(user: event.user));
      } catch (e) {
        log(e.toString());
        emit(FailureSelectedUser(messageError: e.toString()));
      }
    });
  }
}
