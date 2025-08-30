import 'dart:convert';
import 'package:http/http.dart' as http;
import 'suntime.dart';

class ApiService {
  Future<SunTimes> fetchSunriseSunset({
    // double mylocationlat = 14.020308,
    // double mylocationlng = 100.000322,
    required double mylocationlat,
    required double mylocationlng,
  }) async {
    final url = Uri.parse(
      'https://api.sunrisesunset.io/json?lat=$mylocationlat&lng=$mylocationlng&time_format=24',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body) as Map<String, dynamic>;
      return SunTimes.fromJson(map);
    } else {
      throw Exception(
        'Failed to load sunrise/sunset data: ${response.statusCode}',
      );
    }
  }
}
