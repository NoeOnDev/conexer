import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';

import 'custom_button.dart';
import 'labeled_text_field.dart';

class LocationInput extends StatefulWidget {
  final TextEditingController localityController;
  final TextEditingController streetController;
  final Color labelColor;

  const LocationInput({
    super.key,
    required this.localityController,
    required this.streetController,
    this.labelColor = Colors.black,
  });

  @override
  LocationInputState createState() => LocationInputState();
}

class LocationInputState extends State<LocationInput> {
  loc.LocationData? _currentLocation;
  bool _serviceEnabled = false;
  loc.PermissionStatus? _permissionGranted;

  Future<void> _checkLocationService() async {
    loc.Location location = loc.Location();

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _currentLocation = await location.getLocation();
    if (_currentLocation != null) {
      _getAddressFromLatLng(
          _currentLocation!.latitude!, _currentLocation!.longitude!);
    }
  }

  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      setState(() {
        widget.streetController.text = place.street ?? '';
        widget.localityController.text = place.locality ?? '';
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          text: 'Obtener Ubicación',
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          onPressed: _checkLocationService,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Localidad:',
          controller: widget.localityController,
          labelColor: widget.labelColor,
          enabled: false,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Calle:',
          controller: widget.streetController,
          labelColor: widget.labelColor,
          enabled: false,
        ),
      ],
    );
  }
}
