import 'package:employee_management/domain/entities/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  EmployeeModel({
    super.employeeId,
    super.employeeName,
    super.branchId,
    super.positionId,
    super.contractStartDate,
    super.contractEndDate,
  });

  factory EmployeeModel.fromJson(Map<dynamic, dynamic> jsonMap) {
    if (jsonMap['data'] != null) {
      final Map data = jsonMap['data'];
      return EmployeeModel(
        employeeId: data['employee_id'],
        employeeName: data['employee_name'],
        branchId: data['branch_id'],
        positionId: data['position_id'],
        contractStartDate: data['contract_start_date'],
        contractEndDate: data['contract_end_date'],
      );
    }
    return EmployeeModel();
  }

  static List<String> convertToList(List<dynamic> lists) {
    try {
      return lists.map((item) {
        return item.toString();
      }).toList();
    } catch (err) {
      return [];
    }
  }

  static List<EmployeeModel> fromJsonEmployees(Map<String, dynamic> json) {
    var modelList = <EmployeeModel>[];

    if (json != null) {
      final List<dynamic> listItem = json['data'];
      modelList = listItem.map((map) {
        final data = {'data': map};
        return EmployeeModel.fromJson(data);
      }).toList();
    }
    return modelList;
  }
}
