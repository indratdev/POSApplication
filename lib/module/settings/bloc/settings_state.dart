part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class FailureSettings extends SettingsState {
  String messageError;

  FailureSettings({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

// Get all Tables
class LoadingGetAllCategory extends SettingsState {}

class FailureGetAllCategory extends FailureSettings {
  FailureGetAllCategory({required super.messageError});
}

class SuccessGetAllCategory extends SettingsState {
  List<CategoryModel> resultModel;

  SuccessGetAllCategory({
    required this.resultModel,
  });

  @override
  List<Object> get props => [resultModel];
}
// END Get all Tables

// Add new Table
class LoadingAddNewCategory extends SettingsState {}

class FailureAddNewCategory extends FailureSettings {
  FailureAddNewCategory({required super.messageError});
}

class SuccessAddNewCategory extends SettingsState {
  String result;

  SuccessAddNewCategory({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// END Get all Tables

// update Tables
class LoadingUpdateCategory extends SettingsState {}

class FailureUpdateCategory extends FailureSettings {
  FailureUpdateCategory({required super.messageError});
}

class SuccessUpdateCategory extends SettingsState {
  String result;

  SuccessUpdateCategory({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// END update Tables

// delete Tables
class LoadingDeleteCategory extends SettingsState {}

class FailureDeleteCategory extends FailureSettings {
  FailureDeleteCategory({required super.messageError});
}

class SuccessDeleteCategory extends SettingsState {
  String result;

  SuccessDeleteCategory({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// END update Tables