import 'package:flutter/material.dart';
import 'form_page.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              'LaporSir!',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'LaporSir adalah aplikasi pelaporan infrastruktur rusak. Laporkan dan kami akan mengirimkannya.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            Text(
              'Detailed Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Image.asset('assets/images/illustration.png', height: 200), // Tambahkan gambar di folder assets
            SizedBox(height: 20),
            Text(
              'Pelaporan tanpa identitasmu diketahui (anonim).',
              textAlign: TextAlign.center,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormPage()),
                );
              },
              child: Text('Tekan untuk lanjut'),
            ),
          ],
        ),
      ),
    );
  }
}
