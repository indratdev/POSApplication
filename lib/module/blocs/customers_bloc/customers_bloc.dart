import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/customers_model.dart';
import 'package:posapplication/domain/user_repository.dart';
import 'package:posapplication/shared/utils/general_function.dart';

part 'customers_event.dart';
part 'customers_state.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  CustomersBloc() : super(CustomersInitial()) {
    final UserRepository userRepository = UserRepository();
    final GeneralFunction generalFunction = GeneralFunction();

    // get all customers
    on<GetAllCustomersEvent>((event, emit) async {
      emit(LoadingGetAllCustomers());
      try {
        List<CustomersModel> result = await userRepository.readAllCustomers();

        emit(SuccessGetAllCustomers(resultModel: result));
      } catch (e) {
        emit(FailureGetAllCustomers(messageError: e.toString()));
        print(e.toString());
      }
    });

    // add new customer
    on<AddNewCustomerEvent>((event, emit) async {
      try {
        emit(LoadingAddNewCustomer());
        print("jalan");
        String companyID = await userRepository.readCompanyID();
        CustomersModel data = event.customersModel;

        var uniqueID = generalFunction.generateUniqueID();

        Either<String, String> result =
            await userRepository.createNewCustomer(data, companyID, uniqueID);

        result.fold((l) => emit(FailureAddNewCustomer(messageError: l)),
            (r) => emit(SuccessAddNewCustomer(result: r)));
      } catch (e) {
        log(e.toString());
        emit(FailureAddNewCustomer(messageError: e.toString()));
      }
    });

    // update customer
    on<UpdateCustomersEvent>((event, emit) async {
      emit(LoadingUpdateCustomer());
      try {
        // insert data auth user ke users collection
        Either<String, String> result =
            await userRepository.updateCustomer(event.customerModel);
        result.fold(
          (err) => emit(FailureUpdateCustomer(messageError: err.toString())),
          (data) => emit(SuccessUpdateCustomer(result: data)),
        );
      } catch (e) {
        log(e.toString());
        emit(FailureUpdateCustomer(messageError: e.toString()));
      }
    });

    // delete customer
    on<deleteCustomerEvent>((event, emit) async {
      emit(LoadingDeleteCustomers());
      try {
        // // insert data auth user ke users collection
        Either<String, String> result =
            await userRepository.deleteCustomer(event.documentID);

        result.fold(
          (err) => emit(FailureDeleteCustomers(messageError: err.toString())),
          (data) => emit(SuccessDeleteCustomers(result: data)),
        );
      } catch (e) {
        log(e.toString());
        emit(FailureDeleteCustomers(messageError: e.toString()));
      }
    });
  }
}
