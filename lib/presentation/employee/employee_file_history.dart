import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class EmployeeFileHistory extends StatefulWidget {
  final Function onTapBack;
  const EmployeeFileHistory({super.key, required this.onTapBack});

  @override
  State<EmployeeFileHistory> createState() => _EmployeeFileHistoryState();
}

class _EmployeeFileHistoryState extends State<EmployeeFileHistory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   children: [
        //     IconButton(
        //         onPressed: () => widget.onTapBack(),
        //         icon: Icon(Icons.arrow_back)),
        //     Text(
        //       'Add Employee\'s Form',
        //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        //     ),
        //     Expanded(child: SizedBox()),
        //     OutlinedButton(
        //       onPressed: () {
        //         _pickFiles();
        //       },
        //       child: const Text('Upload File'),
        //     ),
        //   ],
        // ),
        Expanded(
          child: Card(
            elevation: 5,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  'File History',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.30,
                  // child: SingleChildScrollView(
                  child: ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                            title: Text('employee-januari-2022-$index.slxs'),
                            subtitle: Text('${index + 5} Employees'),
                          ),
                      separatorBuilder: (context, index) => Divider(
                            color: Colors.grey,
                            thickness: 1,
                            height: 1,
                          ),
                      itemCount: 5),
                  // ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
