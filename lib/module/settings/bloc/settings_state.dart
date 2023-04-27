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

// ------------------------- items

// Get all items
class LoadingGetAllItems extends SettingsState {}

class FailureGetAllItems extends FailureSettings {
  FailureGetAllItems({required super.messageError});
}

class SuccessGetAllItems extends SettingsState {
  List<ItemsModel> resultModel;

  SuccessGetAllItems({
    required this.resultModel,
  });

  @override
  List<Object> get props => [resultModel];
}
// END Get all Tables

// Add new Table
class LoadingAddNewItems extends SettingsState {}

class FailureAddNewItems extends FailureSettings {
  FailureAddNewItems({required super.messageError});
}

class SuccessAddNewItems extends SettingsState {
  String result;

  SuccessAddNewItems({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// END Get all Tables

// update Tables
class LoadingUpdateItems extends SettingsState {}

class FailureUpdateItems extends FailureSettings {
  FailureUpdateItems({required super.messageError});
}

class SuccessUpdateItems extends SettingsState {
  String result;

  SuccessUpdateItems({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// END update Tables

// delete Tables
class LoadingDeleteItems extends SettingsState {}

class FailureDeleteItems extends FailureSettings {
  FailureDeleteItems({required super.messageError});
}

class SuccessDeleteItems extends SettingsState {
  String result;

  SuccessDeleteItems({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// END update Tables

// ------------------------- end items