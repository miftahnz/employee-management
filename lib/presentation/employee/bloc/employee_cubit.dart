import 'package:bloc/bloc.dart';
import 'package:employee_management/data/datasource/base_client.dart';
import 'package:employee_management/data/models/employee.dart';
import 'package:flutter/material.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  // final EmployeeUseCase employeeUseCase;
  // final BulkRegistrationUseCase bulkRegistrationUseCase;

  EmployeeCubit() : super(EmployeeInitialState());

  late List<EmployeeModel> employees = [];
  // FileDataInputEntity fileInfo;

  // Future<void> setFileInfoEvent(FileDataInputEntity file) async {
  //   fileInfo = file;
  // }

  // Future<void> uploadEmployeeEvent() async {
  //   emit(EmployeeDetailLoadingState());
  //   try {
  //     _setJourneyId(JourneyIdConstants.uploadEmployee);
  //     await bulkRegistrationUseCase.uploadFileCustomer(fileInfo,
  //         EmployeeFileEnum.ktp.text, employee.customerId, employee.fileId);
  //     emit(UploadEmployeeLoadedState());
  //   } on UnauthorisedException catch (error) {
  //     EventBus.emit<AuthenticationSubscriberEvent>(
  //         LogOutSubscriberEvent(errorMessage: error.message));
  //   } catch (e) {
  //     emit(EmployeeDetailFailedState(prepareErrorMessageTerm(e)));
  //   }
  // }

  Future<void> getEmployeeList() async {
    emit(EmployeeLoadingState());
    try {
      // employees = employeeEntity;
      // if (employee.bulkUploadId.isNotNullOrEmpty && employee.isHasKtp) {
      //   final result = await employeeUseCase.getEmployee(
      //     bulkUploadId: employee.bulkUploadId,
      //     customerId: employee.customerId,
      //   );
      //   if (result != null) {
      //     employee = result;
      //   }
      // }
      var response = await BaseClient().get('').catchError((e) {});

      // if (response == null) return;

      // print('=======================================');
      // print(response);
      employees = [
        EmployeeModel(
            employeeId: 'EMP_001',
            employeeName: 'SUSAN',
            branchId: 'BRANCH_001',
            positionId: 'JOB_001',
            contractEndDate: DateTime.now(),
            contractStartDate: DateTime.now())
      ];
      emit(GetEmployeeLoadedState());
    } catch (e) {
      emit(EmployeeFailedState(e.toString()));
    }
  }
}
