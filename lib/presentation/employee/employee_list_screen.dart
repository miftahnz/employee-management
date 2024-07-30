import 'package:employee_management/data/mock/mock_employee.dart';
import 'package:employee_management/presentation/employee/bloc/employee_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key, required this.onTapButton});
  final Function onTapButton;

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  DateTime datePicked = DateTime.now();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late EmployeeCubit employeeCubit;

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          firstDate: DateTime(2000),
          lastDate: DateTime(DateTime.now().year + 100),
        );
      },
    ).then((value) {
      setState(() {
        datePicked = value;
        _controller.text = DateFormat('dd/MM/yyyy').format(datePicked);
        _focusNode.unfocus();
      });
    });
  }

  @override
  void initState() {
    employeeCubit = EmployeeCubit();
    employeeCubit.getEmployeeList();
    super.initState();
  }

  @override
  void dispose() {
    employeeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => employeeCubit,
      child: SizedBox(
        child: Column(
          children: [
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Due Date',
                        ),
                        onTap: () {
                          _dialogBuilder(context);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        // _pickFiles();
                        widget.onTapButton().call();
                      },
                      child: const Text('Add Employee')),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildTableEmployee()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableEmployee() {
    return DataTable(
      columnSpacing: 120,
      horizontalMargin: 100,
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Employee ID',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Name',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Branch ID',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Position ID',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Contract Start Date',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Contract End Date',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: List<DataRow>.generate(
        employeeCubit.employees.length,
        (int index) => DataRow(
          cells: <DataCell>[
            DataCell(Text(employeeCubit.employees[index].employeeId ?? '-')),
            DataCell(Text(employeeCubit.employees[index].employeeName ?? '-')),
            DataCell(Text(employeeCubit.employees[index].branchId ?? '-')),
            DataCell(Text(employeeCubit.employees[index].positionId ?? '-')),
            DataCell(Text(employeeCubit.employees[index].contractStartDate !=
                    null
                ? DateFormat('yyyy-MM-dd')
                    .format(employeeCubit.employees[index].contractStartDate!)
                : '-')),
            DataCell(Text(employeeCubit.employees[index].contractEndDate != null
                ? DateFormat('yyyy-MM-dd')
                    .format(employeeCubit.employees[index].contractEndDate!)
                : '-')),
          ],
        ),
      ),
    );
  }
}
