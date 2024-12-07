import 'package:flutter/material.dart';
import 'package:laporsir/screens/login_page.dart';    // Halaman Login
import 'package:laporsir/screens/intro_page.dart';    // Halaman Intro setelah login
import 'package:laporsir/screens/form_page.dart';     // Halaman Form
import 'package:laporsir/screens/success_page.dart';  // Halaman Success
import 'package:laporsir/screens/view_reports_page.dart'; // Halaman View Reports

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LaporSir',
      initialRoute: '/login', 
      routes: {
        '/login': (context) => LoginPage(), 
        '/': (context) => IntroPage(), 
        '/form': (context) => FormPage(), 
        '/success': (context) => SuccessPage(reports: []),
        '/viewReports': (context) => ViewReportsPage(), 
      },
    );
  }
}
