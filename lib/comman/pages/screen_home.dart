// import 'package:minna/comman/const/const.dart';
// import 'package:minna/comman/pages/screen%20bookings/screen_booking.dart';
// import 'package:minna/bus/pages/screen%20bus%20home%20/bus_home.dart';
// import 'package:minna/comman/pages/screen%20help/screen_help.dart';
// import 'package:minna/comman/pages/screen%20my%20account/my_account_page.dart';
// import 'package:minna/comman/pages/tab%20page/tab_home.dart';
// import 'package:flutter/material.dart';

// class Screenhome extends StatefulWidget {
//   const Screenhome({Key? key}) : super(key: key);

//   @override
//   State<Screenhome> createState() => _ScreenhomeState();
// }

// class _ScreenhomeState extends State<Screenhome> {
//   int _currentIndex = 0;

//   // Pages for bottom navigation
//   final List<Widget> _pages = [
//     const CommonTabPage(), // Your bus booking content
//     const ScreenBooking(),
//     // const ScreenHelp(),
//     const MyAccountPage(),
//   ];

//   // Bottom navigation items
//   final List<BottomNavigationBarItem> _bottomNavItems = const [
//     BottomNavigationBarItem(
//       icon: Icon(Icons.home_outlined),
//       activeIcon: Icon(Icons.home),
//       label: 'Home',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.bookmarks_outlined),
//       activeIcon: Icon(Icons.bookmarks),
//       label: 'Bookings',
//     ),
//     // BottomNavigationBarItem(
//     //   icon: Icon(Icons.help_outline),
//     //   activeIcon: Icon(Icons.help),
//     //   label: 'Help',
//     // ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.person_outline),
//       activeIcon: Icon(Icons.person),
//       label: 'Account',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: _pages[_currentIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: const Offset(0, -1),
//             ),
//           ],
//         ),
//         child: BottomNavigationBar(
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//           items: _bottomNavItems,
//           selectedItemColor: maincolor1,
//           unselectedItemColor: Colors.grey,
//           showUnselectedLabels: true,
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.white,
//         ),
//       ),
//     );
//   }
// }
