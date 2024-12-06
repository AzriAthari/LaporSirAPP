import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/report.dart';
import 'dart:io';

class ViewReportsPage extends StatefulWidget {
  @override
  _ViewReportsPageState createState() => _ViewReportsPageState();
}

class _ViewReportsPageState extends State<ViewReportsPage> {
  List<Report> _reports = [];

  @override
  void initState() {
    super.initState();
    loadReports();
  }

  Future<void> loadReports() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> reports = prefs.getStringList('reports') ?? [];

    setState(() {
      _reports = reports
          .map((reportJson) => Report.fromJson(jsonDecode(reportJson)))
          .toList();
    });
  }

  Future<void> deleteReport(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> reports = prefs.getStringList('reports') ?? [];

    // Dialog konfirmasi
    bool? confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Laporan'),
          content: Text('Apakah Anda yakin ingin menghapus laporan ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      // Hapus laporan dari list
      reports.removeAt(index);
      await prefs.setStringList('reports', reports);

      setState(() {
        _reports.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Laporan berhasil dihapus.'),
      ));
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Daftar Laporan')),
    body: _reports.isEmpty
        ? Center(child: Text('Tidak ada laporan yang tersimpan.'))
        : ListView.builder(
            itemCount: _reports.length,
            itemBuilder: (context, index) {
              final report = _reports[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(report.title, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Lokasi: ${report.location}', style: TextStyle(fontSize: 14)),
                        Text('Keluhan: ${report.complaint}', style: TextStyle(fontSize: 14)),
                        if (report.imagePath != null && File(report.imagePath!).existsSync())
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Image.file(
                              File(report.imagePath!),
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteReport(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
