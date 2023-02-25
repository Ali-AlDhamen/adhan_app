import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationAPI {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    Position position;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    await Geolocator.requestPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     return Future.error('Location permissions are denied');
    //   }
    // }
    // if (permission == LocationPermission.deniedForever) {
    //   return Future.error(
    //       'Location permissions are permanently denied, we cannot request permissions.');
    // }
    position = await Geolocator.getCurrentPosition();
    return position;
  }

  static Future<List<String>> getCityName(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: 'en');

    return [placemarks[0].locality!, placemarks[0].country!];
  }

  Future<List<String?>> getCityAndCountryByAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    List<Placemark> placemarks = await placemarkFromCoordinates(
        locations[0].latitude, locations[0].longitude,
        localeIdentifier: 'en');
    Placemark placemark = placemarks[0];
    String? city = placemark.locality;
    String? country = placemark.country;
    return [city, country];
  }
}
