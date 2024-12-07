import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laporsir/screens/success_page.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/report.dart';
import 'map_picker_page.dart';
import 'view_reports_page.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController();
  String? _imagePath;
  LatLng? _pickedLocation;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _pickLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapPickerPage()),
    );

    if (result != null && result is LatLng) {
      setState(() {
        _pickedLocation = result;
        _locationController.text =
            'Lat: ${_pickedLocation!.latitude}, Lng: ${_pickedLocation!.longitude}';
      });
    }
  }

  // Fungsi untuk memvalidasi form
  bool _validateForm() {
    if (_titleController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _complaintController.text.isEmpty ||
        _imagePath == null) {
      return false;
    }
    return true;
  }

  Future<void> saveReport() async {
    if (!_validateForm()) {
      // Jika ada field yang kosong, tampilkan pesan kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap isi semua kolom dan pilih foto.')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    List<String> reports = prefs.getStringList('reports') ?? [];

    Report newReport = Report(
      title: _titleController.text,
      location: _locationController.text,
      complaint: _complaintController.text,
      imagePath: _imagePath,
    );

    try {
      reports.add(jsonEncode(newReport.toJson()));
      await prefs.setStringList('reports', reports);

      _titleController.clear();
      _locationController.clear();
      _complaintController.clear();

      setState(() {
        _imagePath = null;
      });

      // Navigasi ke halaman SuccessPage dengan data laporan yang baru disimpan
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessPage(reports: reports),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Laporan berhasil disimpan!'),
      ));
    } catch (e) {
      print('Error saat menyimpan laporan: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Gagal menyimpan laporan.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('Form Laporan'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewReportsPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Judul'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Lokasi (Koordinat)'),
                readOnly: true,
                onTap: _pickLocation,
              ),
              ElevatedButton(
                onPressed: _pickLocation,
                child: Text('Pilih Lokasi di Peta'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _complaintController,
                decoration: InputDecoration(labelText: 'Keluhan'),
                maxLines: 3,
              ),
              SizedBox(height: 10),
              if (_imagePath != null)
                Image.file(
                  File(_imagePath!),
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pilih Foto Bukti'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveReport,
                child: Text('Simpan Laporan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
