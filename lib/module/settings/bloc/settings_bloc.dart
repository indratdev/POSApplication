import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/export_model.dart';
import '../../../data/service/user_service/user_service.dart';
import '../../../domain/auth_repository.dart';
import '../../../domain/category_repository.dart';
import '../../../domain/items_repository.dart';
import '../../../domain/user_repository.dart';
import '../../../shared/utils/general_function.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UserRepository userRepository = UserRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final ItemsRepository itemsRepository = ItemsRepository();
  final UserService userService = UserService();
  final AuthRepository authRepository = AuthRepository();
  final GeneralFunction generalFunction = GeneralFunction();

  SettingsBloc() : super(SettingsInitial()) {
    on<GetAllCategoryEvent>((event, emit) async {
      emit(LoadingGetAllCategory());
      try {
        String companyID = await userRepository.readCompanyID();
        List<CategoryModel> result =
            await categoryRepository.readAllCategory(companyID);

        emit(SuccessGetAllCategory(resultModel: result));
      } catch (e) {
        print(e.toString());
        emit(FailureGetAllCategory(messageError: e.toString()));
      }
    });

    // // add new category
    on<AddNewCategoryEvent>((event, emit) async {
      try {
        emit(LoadingAddNewCategory());

        String companyID = await userRepository.readCompanyID();
        String companyName = await userRepository.readCompanyName();
        String tableID = generalFunction.generateUniqueGeneralID(companyName);
        CategoryModel data = event.categoryModel;

        Either<String, String> result = await categoryRepository
            .createNewCategory(data, companyID, tableID);
        result.fold((l) => emit(FailureAddNewCategory(messageError: l)),
            (r) => emit(SuccessAddNewCategory(result: r)));
      } catch (e) {
        log(e.toString());
        emit(FailureAddNewCategory(messageError: e.toString()));
      }
    });

    // update category
    on<UpdateCategoryEvent>((event, emit) async {
      emit(LoadingUpdateCategory());
      try {
        // insert data auth user ke users collection
        Either<String, String> result =
            await categoryRepository.updateCategory(event.categoryModel);
        result.fold(
            (l) => emit(FailureUpdateCategory(messageError: l.toString())),
            (r) => emit(SuccessUpdateCategory(result: r)));
      } catch (e) {
        log(e.toString());
        emit(FailureUpdateCategory(messageError: e.toString()));
      }
    });

    // delete category
    on<deleteCategoryEvent>((event, emit) async {
      emit(LoadingDeleteCategory());
      try {
        Either<String, String> result =
            await categoryRepository.deleteCategory(event.documentID);
        result.fold(
            (l) => emit(FailureDeleteCategory(messageError: l.toString())),
            (r) => emit(SuccessDeleteCategory(result: r)));
      } catch (e) {
        log(e.toString());
        emit(FailureDeleteCategory(messageError: e.toString()));
      }
    });

    // ------- items
    on<GetAllItemsEvent>((event, emit) async {
      emit(LoadingGetAllItems());
      try {
        print("runnn...");
        String companyID = await userRepository.readCompanyID();
        List<ItemsModel> result = await itemsRepository.readAllItems(companyID);

        emit(SuccessGetAllItems(resultModel: result));
      } catch (e) {
        print(e.toString());
        emit(FailureGetAllItems(messageError: e.toString()));
      }
    });

    // // // add new category
    // on<AddNewCategoryEvent>((event, emit) async {
    //   try {
    //     emit(LoadingAddNewCategory());

    //     String companyID = await userRepository.readCompanyID();
    //     String companyName = await userRepository.readCompanyName();
    //     String tableID = generalFunction.generateUniqueGeneralID(companyName);
    //     CategoryModel data = event.categoryModel;

    //     Either<String, String> result = await categoryRepository
    //         .createNewCategory(data, companyID, tableID);
    //     result.fold((l) => emit(FailureAddNewCategory(messageError: l)),
    //         (r) => emit(SuccessAddNewCategory(result: r)));
    //   } catch (e) {
    //     log(e.toString());
    //     emit(FailureAddNewCategory(messageError: e.toString()));
    //   }
    // });

    // // update category
    // on<UpdateCategoryEvent>((event, emit) async {
    //   emit(LoadingUpdateCategory());
    //   try {
    //     // insert data auth user ke users collection
    //     Either<String, String> result =
    //         await categoryRepository.updateCategory(event.categoryModel);
    //     result.fold(
    //         (l) => emit(FailureUpdateCategory(messageError: l.toString())),
    //         (r) => emit(SuccessUpdateCategory(result: r)));
    //   } catch (e) {
    //     log(e.toString());
    //     emit(FailureUpdateCategory(messageError: e.toString()));
    //   }
    // });

    // // delete category
    // on<deleteCategoryEvent>((event, emit) async {
    //   emit(LoadingDeleteCategory());
    //   try {
    //     Either<String, String> result =
    //         await categoryRepository.deleteCategory(event.documentID);
    //     result.fold(
    //         (l) => emit(FailureDeleteCategory(messageError: l.toString())),
    //         (r) => emit(SuccessDeleteCategory(result: r)));
    //   } catch (e) {
    //     log(e.toString());
    //     emit(FailureDeleteCategory(messageError: e.toString()));
    //   }
    // });
    // ------- end items
  }
}
