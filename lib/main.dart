  import 'package:flutter/material.dart';
import 'package:laporsir/screens/form_page.dart';
import 'package:laporsir/screens/success_page.dart';
import 'package:laporsir/screens/view_reports_page.dart';
  import 'screens/intro_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LaporSir',
      initialRoute: '/',
      routes: {
        '/': (context) => IntroPage(),
        '/form': (context) => FormPage(),
        '/success': (context) => SuccessPage(reports: []),
        '/viewReports': (context) => ViewReportsPage(),
      },
    );
  }
}
