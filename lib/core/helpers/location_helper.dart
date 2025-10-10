import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../constant.dart' show PERMISSION_PERMANENT_DENIED, PERMISSION_DENIED;

class LocationHelper {
  static Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw ('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw (PERMISSION_DENIED);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw (PERMISSION_PERMANENT_DENIED);
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }

  static Future<String> getCityName() async {
    final pos = await _determinePosition();
    final placemarks = await placemarkFromCoordinates(
      pos.latitude,
      pos.longitude,
    );
    if (placemarks.isEmpty) return 'Unknown';
    final p = placemarks.first;
    return p.locality ??
        p.subAdministrativeArea ??
        p.administrativeArea ??
        p.country ??
        'Unknown';
  }
}
