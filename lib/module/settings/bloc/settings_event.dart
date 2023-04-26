part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class GetAllCategoryEvent extends SettingsEvent {}

class AddNewCategoryEvent extends SettingsEvent {
  CategoryModel categoryModel;

  AddNewCategoryEvent({
    required this.categoryModel,
  });
}

class UpdateCategoryEvent extends SettingsEvent {
  CategoryModel categoryModel;

  UpdateCategoryEvent({
    required this.categoryModel,
  });
}

class deleteCategoryEvent extends SettingsEvent {
  String documentID;

  deleteCategoryEvent({
    required this.documentID,
  });
}
