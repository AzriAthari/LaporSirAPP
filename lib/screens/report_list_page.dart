import 'package:flutter/material.dart';
import '../models/report.dart';

class ReportListPage extends StatefulWidget {
  const ReportListPage({super.key});

  @override
  _ReportListPageState createState() => _ReportListPageState();
}

class _ReportListPageState extends State<ReportListPage> {
  List<Report> reports = []; // Data laporan

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ambil laporan yang sudah dikirim dari SharedPreferences atau argumen
    final args = ModalRoute.of(context)!.settings.arguments as List<Report>?;
    if (args != null) {
      setState(() {
        reports = args;
      });
    }
  }

  void deleteReport(int index) {
    setState(() {
      reports.removeAt(index);
    });
    // Simpan ulang data ke SharedPreferences jika menggunakan penyimpanan lokal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Laporan'),
      ),
      body: reports.isEmpty
          ? const Center(
              child: Text('Belum ada laporan yang dikirim.'),
            )
          : ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(report.title),
                    subtitle: Text(report.location),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteReport(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
