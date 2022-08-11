import 'package:flutter/material.dart';
import 'package:googlemap/homescreen.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

class UserLocationWithGoogleMap with ChangeNotifier {
  bool? _serviceEnabled;
  PermissionStatus? _permissionStatus;
  final Location _location = Location();
  Location get locadata => _location;

  double? lat;
  double? lon;

  double? get getlat => lat;
  double? get getlon => lon;

  Future getuserloc() async {
    LocationData _locationData;
    _locationData = await _location.getLocation();
    lat = _locationData.latitude;
    lon = _locationData.longitude;
    print(_locationData.latitude);
    print(_locationData.longitude);
    notifyListeners();
  }

  bool get getloc => getuserloc() as bool;

  // LocationData? get getloccordinates {
  //   notifyListeners();

  //   if (_locationData!.latitude != null && _locationData!.longitude != null) {
  //     return null;
  //   } else {
  //     return _locationData!;
  //   }
  // }

  Future userLocationStatus() async {
    _serviceEnabled = await _location.serviceEnabled();
    _serviceEnabled ??= await _location.requestService();
    if (_serviceEnabled == null) {
      return;
    }
    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
    }
    if (_permissionStatus != PermissionStatus.granted) {
      return;
    }
    notifyListeners();
    // _locationData =await _location.getLocation();
  }
}
