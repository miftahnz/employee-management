import 'package:employee_management/data/mock/mock_employee.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }

  Widget _buildTableEmployee() {
    return DataTable(
      columnSpacing: 300,
      horizontalMargin: 100,
      columns: const <DataColumn>[
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
              'Age',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Position',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Branch',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: List<DataRow>.generate(
        mockDataEmployees.length,
        (int index) => DataRow(
          cells: <DataCell>[
            DataCell(Text(mockDataEmployees[index]['name'] ?? 'empty')),
            DataCell(Text(mockDataEmployees[index]['age'] ?? 'empty')),
            DataCell(Text(mockDataEmployees[index]['position'] ?? 'empty')),
            DataCell(Text(mockDataEmployees[index]['branch'] ?? 'empty')),
          ],
        ),
      ),
    );
  }
}
