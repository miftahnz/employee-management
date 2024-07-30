import 'package:employee_management/presentation/employee/employee_file_history.dart';
import 'package:employee_management/presentation/employee/employee_form_screen.dart';
import 'package:employee_management/presentation/employee/employee_list_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  bool isUploadFile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          _buildSidebarWidget(),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: _buildContent(),
          ))
        ],
      ),
    );
  }

  Widget _buildSidebarWidget() {
    return NavigationRail(
      elevation: 5,
      minWidth: 120,
      selectedIndex: selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          selectedIndex = index;
          isUploadFile = false;
        });
      },
      labelType: NavigationRailLabelType.all,
      destinations: <NavigationRailDestination>[
        NavigationRailDestination(
          padding: const EdgeInsets.all(10),
          icon: Image.asset(
            'web/icons/employee.png',
            height: 30,
          ),
          selectedIcon: Image.asset(
            'web/icons/selected-employee.png',
            height: 30,
          ),
          label: const Text('Employees'),
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.all(10),
          icon: Icon(Icons.history),
          selectedIcon: Icon(Icons.history),
          label: const Text('File History'),
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.all(10),
          icon: Image.asset(
            'web/icons/branch.png',
            height: 30,
          ),
          selectedIcon: Image.asset(
            'web/icons/selected-branch.png',
            height: 30,
          ),
          label: const Text('Branch'),
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.all(10),
          icon: Image.asset(
            'web/icons/position.png',
            height: 30,
          ),
          selectedIcon: Image.asset(
            'web/icons/selected-position.png',
            height: 30,
          ),
          label: const Text('Positions'),
        ),
      ],
    );
  }

  Widget _buildContent() {
    switch (selectedIndex) {
      case 1:
        return EmployeeFileHistory(
          onTapBack: () => {
            setState(() {
              isUploadFile = false;
            })
          },
        );
      case 2:
        return const Center(
          child: Text('POSITIONS'),
        );
      case 3:
        return const Center(child: Text('text'));
      default:
        if (isUploadFile) {
          return EmployeeFormScreen(
            onTapBack: () => {
              setState(() {
                isUploadFile = false;
              })
            },
          );
        }
        return EmployeeListScreen(
          onTapButton: () {
            setState(() {
              isUploadFile = true;
            });
          },
        );
    }
  }
}
