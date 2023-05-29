part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

// category
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

class SelectedCategoryEvent extends SettingsEvent {
  CategoryModel categoryModel;

  SelectedCategoryEvent({
    required this.categoryModel,
  });
}

// end category

// items
class GetAllItemsEvent extends SettingsEvent {}

class AddNewItemsEvent extends SettingsEvent {
  ItemsModel itemsModel;

  AddNewItemsEvent({
    required this.itemsModel,
  });
}

class UpdateItemsEvent extends SettingsEvent {
  ItemsModel itemsModel;

  UpdateItemsEvent({
    required this.itemsModel,
  });
}

class deleteItemsEvent extends SettingsEvent {
  String itemID;

  deleteItemsEvent({
    required this.itemID,
  });
}

// end items