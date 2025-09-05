import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;     
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiService {
  static String get baseUrl {
    if (kIsWeb) return 'http://localhost:3000/api';
    try {
      if (Platform.isAndroid) {
        // Android emulator uses 10.0.2.2 to reach host machine
        return 'http://10.0.2.2:3000/api';
      }
      // iOS simulator / desktop
      return 'http://localhost:3000/api';
    } catch (_) {
      return 'http://localhost:3000/api';
    }
  }

  static Future<void> sendName(String name) async {
    final url = Uri.parse('$baseUrl/players');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'timestamp': DateTime.now().toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      print('Successfully sent: $name');
      print('Server response: ${response.body}');
    } else {
      print('Failed to send name. Status: ${response.statusCode}');
      print('Body: ${response.body}');
    }
  }
}