// Drawer(
//             backgroundColor: Colors.black12,
//             // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//             // Add a ListView to the drawer. This ensures the user can scroll
//             // through the options in the drawer if there isn't enough vertical
//             // space to fit everything.
//             child: ListView(
//               // Important: Remove any padding from the ListView.
//               padding: EdgeInsets.zero,
//               children: [
//                 const DrawerHeader(
//                   child: Text('Drawer Header'),
//                 ),
//                 ListTile(
//                   title: const Text('Employees'),
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                     setState(() {
//                       selectedIndex = 0;
//                     });
//                   },
//                 ),
//                 ListTile(
//                   title: const Text('Positions'),
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                     setState(() {
//                       selectedIndex = 1;
//                     });
//                   },
//                 ),
//                 ListTile(
//                   title: const Text('Branch'),
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                     setState(() {
//                       selectedIndex = 2;
//                     });
//                   },
//                 ),
//                 ListTile(
//                   title: const Text('Profiles'),
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                     setState(() {
//                       selectedIndex = 3;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),