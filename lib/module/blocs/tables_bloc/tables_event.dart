part of 'tables_bloc.dart';

abstract class TablesEvent extends Equatable {
  const TablesEvent();

  @override
  List<Object> get props => [];
}

class GetAllTablesEvent extends TablesEvent {}

class AddNewTablesEvent extends TablesEvent {
  TablesModel tableModel;

  AddNewTablesEvent({
    required this.tableModel,
  });
}

class UpdateTablesEvent extends TablesEvent {
  TablesModel tableModel;

  UpdateTablesEvent({
    required this.tableModel,
  });
}

class deleteTablesEvent extends TablesEvent {
  String documentID;

  deleteTablesEvent({
    required this.documentID,
  });
}
