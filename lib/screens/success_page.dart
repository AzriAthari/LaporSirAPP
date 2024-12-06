import 'package:flutter/material.dart';
import '../models/report.dart';

import 'view_reports_page.dart';

class SuccessPage extends StatelessWidget {
  final List<String> reports; // Data laporan yang baru disimpan

  const SuccessPage({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Berhasil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Laporan berhasil disimpan!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Arahkan pengguna ke halaman daftar laporan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewReportsPage(),
                  ),
                );
              },
              child: const Text('Lihat Semua Laporan'),
            ),
          ],
        ),
      ),
    );
  }
}
