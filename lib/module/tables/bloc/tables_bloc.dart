import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/domain/table_repository.dart';
import 'package:posapplication/shared/utils/general_function.dart';

import '../../../data/model/tables_model.dart';
import '../../../data/service/user_service/user_service.dart';
import '../../../domain/auth_repository.dart';
import '../../../domain/user_repository.dart';

part 'tables_event.dart';
part 'tables_state.dart';

class TablesBloc extends Bloc<TablesEvent, TablesState> {
  final UserRepository userRepository = UserRepository();
  final TableRepository tableRepository = TableRepository();
  final UserService userService = UserService();
  final AuthRepository authRepository = AuthRepository();
  final GeneralFunction generalFunction = GeneralFunction();

  TablesBloc() : super(TablesInitial()) {
    on<GetAllTablesEvent>((event, emit) async {
      emit(LoadingGetAllTable());
      try {
        String companyID = await userRepository.readCompanyID();
        List<TablesModel> result =
            await tableRepository.readAllTables(companyID);

        emit(SuccessGetAllTable(resultModel: result));
      } catch (e) {
        print(e.toString());
        emit(FailureGetAllTable(messageError: e.toString()));
      }
    });

    // add new table
    on<AddNewTablesEvent>((event, emit) async {
      try {
        emit(LoadingAddNewTable());

        String companyID = await userRepository.readCompanyID();
        String tableID = generalFunction.generateUniqueTableID();
        TablesModel data = event.tableModel;

        Either<String, String> result =
            await tableRepository.createNewTable(data, companyID, tableID);
        result.fold((l) => emit(FailureAddNewTable(messageError: l)),
            (r) => emit(SuccessAddNewTable(result: r)));
      } catch (e) {
        log(e.toString());
        emit(FailureAddNewTable(messageError: e.toString()));
      }
    });

    // update table
    on<UpdateTablesEvent>((event, emit) async {
      emit(LoadingUpdateTable());
      try {
        // insert data auth user ke users collection
        Either<String, String> result =
            await tableRepository.updateTable(event.tableModel);
        result.fold((l) => emit(FailureUpdateTable(messageError: l.toString())),
            (r) => emit(SuccessUpdateTable(result: r)));
      } catch (e) {
        log(e.toString());
        emit(FailureUpdateTable(messageError: e.toString()));
      }
    });

    // delete user
    on<deleteTablesEvent>((event, emit) async {
      emit(LoadingDeleteTable());
      try {
        // // insert data auth user ke users collection
        Either<String, String> result =
            await tableRepository.deleteTable(event.documentID);
        result.fold((l) => emit(FailureDeleteTable(messageError: l.toString())),
            (r) => emit(SuccessDeleteTable(result: r)));
      } catch (e) {
        log(e.toString());
        emit(FailureDeleteTable(messageError: e.toString()));
      }
    });
  }
}
