part of 'employee_cubit.dart';

@immutable
abstract class EmployeeState {}

class EmployeeInitialState extends EmployeeState {}

class EmployeeLoadingState extends EmployeeState {}

class GetEmployeeLoadedState extends EmployeeState {}

class UploadEmployeeLoadedState extends EmployeeState {}

class EmployeeFailedState extends EmployeeState {
  final String errorMessage;

  EmployeeFailedState(this.errorMessage);
}

