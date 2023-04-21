part of 'tables_bloc.dart';

abstract class TablesState extends Equatable {
  const TablesState();

  @override
  List<Object> get props => [];
}

class TablesInitial extends TablesState {}

class FailureTables extends TablesState {
  String messageError;

  FailureTables({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

// Get all Tables
class LoadingGetAllTable extends TablesState {}

class FailureGetAllTable extends FailureTables {
  FailureGetAllTable({required super.messageError});
}

class SuccessGetAllTable extends TablesState {
  List<TablesModel> resultModel;

  SuccessGetAllTable({
    required this.resultModel,
  });

  @override
  List<Object> get props => [resultModel];
}
// END Get all Tables

// Add new Table
class LoadingAddNewTable extends TablesState {}

class FailureAddNewTable extends FailureTables {
  FailureAddNewTable({required super.messageError});
}

class SuccessAddNewTable extends TablesState {
  String result;

  SuccessAddNewTable({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// END Get all Tables

// update Tables
class LoadingUpdateTable extends TablesState {}

class FailureUpdateTable extends FailureTables {
  FailureUpdateTable({required super.messageError});
}

class SuccessUpdateTable extends TablesState {
  String result;

  SuccessUpdateTable({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// END update Tables

// delete Tables
class LoadingDeleteTable extends TablesState {}

class FailureDeleteTable extends FailureTables {
  FailureDeleteTable({required super.messageError});
}

class SuccessDeleteTable extends TablesState {
  String result;

  SuccessDeleteTable({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// END update Tables