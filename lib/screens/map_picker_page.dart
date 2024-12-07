import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart'; // Import plugin location

class MapPickerPage extends StatefulWidget {
  @override
  _MapPickerPageState createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  LatLng _pickedLocation = LatLng(-6.2088, 106.8456); 
  GoogleMapController? _mapController;

  // Fungsi untuk mengambil lokasi pengguna
  Future<void> _getUserLocation() async {
    Location location = Location();

    // Memeriksa status layanan lokasi
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        // Jika layanan lokasi tidak aktif
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        // Jika izin lokasi tidak diberikan
        return;
      }
    }

    // Mendapatkan lokasi pengguna saat ini
    var currentLocation = await location.getLocation();

    setState(() {
      _pickedLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });

    // Memusatkan peta ke lokasi pengguna
    _mapController?.animateCamera(
      CameraUpdate.newLatLng(_pickedLocation),
    );
  }

  // Fungsi untuk menandai lokasi yang dipilih
  void _onMapTap(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  // Fungsi untuk mengonfirmasi lokasi yang dipilih
  void _confirmLocation() {
    Navigator.pop(context, _pickedLocation);
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation(); // Mendapatkan lokasi pengguna saat pertama kali membuka halaman
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Lokasi'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _pickedLocation,
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            onTap: _onMapTap,
            markers: {
              Marker(
                markerId: MarkerId('picked-location'),
                position: _pickedLocation,
              ),
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _confirmLocation,
              child: Text('Konfirmasi Lokasi'),
            ),
          ),
        ],
      ),
    );
  }
}
