import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/data/model/ops_daily_model.dart';
import 'package:posapplication/data/model/profile_model.dart';
import 'package:posapplication/data/model/users_model.dart';
import 'package:posapplication/data/service/auth_service/auth_service.dart';
import 'package:posapplication/data/service/signInSignUp.dart';
import 'package:posapplication/data/service/user_service/user_service.dart';
import 'package:posapplication/domain/hive_repository.dart';
import 'package:posapplication/domain/table_repository.dart';
import 'package:posapplication/domain/user_repository.dart';
import 'package:posapplication/shared/utils/DateUtil/dateutil.dart';
import 'package:posapplication/shared/utils/shared_preferences/myshared_preferences.dart';

import '../../../data/model/category_model.dart';
import '../../../data/model/tables_model.dart';
import '../../../domain/category_repository.dart';
import '../../../domain/owner_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();
  final OwnerRepository ownerRepository = OwnerRepository();
  final HiveRepository hiveRepository = HiveRepository();
  final UserRepository userRepository = UserRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final TableRepository tableRepository = TableRepository();

  MySharedPreferences mySharedP = MySharedPreferences();
  UserService userService = UserService();

  AuthBloc() : super(AuthInitial()) {
    on<RegisterRestoEvent>((event, emit) async {
      try {
        emit(LoadingRegisterResto());
        String messageError = "";
        SignInSignUpResult userData = SignInSignUpResult();

        var regisUser = await authService.registerUser(
            event.email, event.password, RoleUsers.owner);

        regisUser.fold(
          (l) => messageError = l.message,
          (data) => userData = data,
        );

        // kalau register user berhasil
        if (regisUser.isRight()) {
          var resultSaveUser = await userService.saveUserData(RoleUsers.owner);
          resultSaveUser.fold((err) {
            emit(FailureRegisterResto(messageError: "$messageError $err"));
          }, (data) {
            emit(SuccessRegisterResto(result: userData, message: data));
          });
        } else {
          emit(FailureRegisterResto(messageError: messageError));
        }
      } catch (e) {
        log(e.toString());
        emit(FailureRegisterResto(messageError: e.toString()));
      }
    });

    // // register user
    // on<RegisterRestoEvent>(
    //   (event, emit) async {
    //     emit(LoadingRegisterResto());
    //     try {
    //       String emailUser = event.email;
    //       String passwordUser = event.password;

    //       // saveUser(SignInSignUpResult r) async {
    //       //   var resultSaveUser =
    //       //       await userService.saveUserData(RoleUsers.owner);
    //       //   resultSaveUser.fold(
    //       //       (l) => emit(FailureRegisterResto(messageError: l)),
    //       //       (data) => emit(SuccessRegisterResto(result: r, message: data)));
    //       // }

    //       var result =
    //           await authService.registerUser(emailUser, passwordUser, "Owner");

    //       result.fold((l) {
    //         emit(FailureRegisterResto(messageError: l.message));
    //       }, (r) {
    //         saveUser(r);
    //       });
    //     } catch (e) {
    //       emit(FailureRegisterResto(messageError: e.toString()));
    //     }
    //   },
    //   // transformer: sequential(),
    // );

    // forgot password
    on<ForgotPasswordEvent>((event, emit) async {
      emit(LoadingForgotPassword());
      try {
        var result = await AuthService.forgotPassword(email: event.email);
        result.fold((err) {
          emit(FailureForgotPassword(messageError: err));
        }, (data) {
          emit(SuccessForgotPassword(
              result: "Periksa email anda untuk reset password"));
        });
      } catch (e) {
        emit(FailureForgotPassword(messageError: e.toString()));
      }
    });

    // login
    on<LoginUserEvent>((event, emit) async {
      Map<String, dynamic> users = {};
      emit(LoadingLoginUser());
      try {
        var result = await AuthService.signInWithEmailNew(
            email: event.email, pass: event.password);

        result.fold((l) {
          emit(FailureLoginUser(messageError: l));
        }, (data) async {
          Box profileBox, currentUserBox, opsDailytBox;
          profileBox = await ownerRepository.isBoxProfileAlreadyOpen();
          currentUserBox = await ownerRepository.isBoxCurrentUserAlreadyOpen();
          opsDailytBox = await ownerRepository.isBoxOpsDailyAlreadyOpen();

          // if profile box empty, check from firebase
          if (profileBox.isEmpty) {
            // read profile company
            Map<String, dynamic> profiles =
                await ownerRepository.readProfileCompany();

            await hiveRepository
                .createProfileCompanytoBox(ProfileModel.fromJson(profiles));

            // set current user login
            // await hiveRepository
            //     .createUserLoginToHive(UsersModel.fromJson(data));
          }

          // if current login user box empty, check from firebase
          if (currentUserBox.isEmpty) {
            await hiveRepository
                .createUserLoginToHive(UsersModel.fromJson(data));
          }

          // cek ops daily init
          if (opsDailytBox.isEmpty) {
            List<UsersModel> userList = await userRepository.readAllUser();
            await hiveRepository.createOpsDailytoBox(OpsDailyModel(
              // initDate: DateUtil.convertyyyyMMdd(
              //     DateTime.now().subtract(Duration(days: 1))),
              initDate: DateUtil.convertyyyyMMdd(DateTime.now()),
              userList: userList,
            ));

            // insert user
            await hiveRepository.createUserFromFirebaseToHive(userList);
          } else {
            // compare kl tgl nya beda hapus -> insert baru
            OpsDailyModel result = opsDailytBox.values.first;
            if (DateUtil.compareDate(
                result.initDate!, DateUtil.getDateyyyyMMdd())) {
              // do nothing
            } else {
              // tanggal di hive beda dengan sekarang
              // insert baru ambil dari firebase
              List<UsersModel> userList = await userRepository.readAllUser();
              List<CategoryModel> categoryList =
                  await categoryRepository.readAllCategory(
                      await hiveRepository.readProfileCompanyIDFromBox());
              List<TablesModel> tableList = await tableRepository.readAllTables(
                  await hiveRepository.readProfileCompanyIDFromBox());

              await hiveRepository.rewriteOpsDailytoBox(OpsDailyModel(
                initDate: DateUtil.convertyyyyMMdd(DateTime.now()),
                // userList: userList,
                categoryList: categoryList,
                tableList: tableList,
              ));

              // insert user
              await hiveRepository.createUserFromFirebaseToHive(userList);
            }
          }
        });

        emit(SuccessLoginUser(result: users));
      } catch (e) {
        emit(FailureLoginUser(messageError: e.toString()));
      }
    });
  }
}
