import 'package:flutter/material.dart';
import 'package:laporsir/screens/intro_page.dart'; 

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == 'admin' && password == 'admin') {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SALAH// Username & pwnya = admin ')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 98, 148, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'LaporSir',
              style: TextStyle(
                fontSize: 40,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 50),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Username',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(),
              ),
              obscureText: true, 
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 73, 162, 235), backgroundColor: Colors.black,
                minimumSize: Size(121, 60), // Ukuran tombol
              ),
            ),
          ],
        ),
      ),
    );
  }
}
