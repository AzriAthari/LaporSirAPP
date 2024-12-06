import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPickerPage extends StatefulWidget {
  @override
  _MapPickerPageState createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  LatLng _pickedLocation = LatLng(-6.2088, 106.8456); // Lokasi default (Jakarta)

  void _onMapTap(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  void _confirmLocation() {
    Navigator.pop(context, _pickedLocation);
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
