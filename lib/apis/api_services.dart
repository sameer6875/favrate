import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = "https://reqres.in/api/users?page=2";

  static Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['data'];
      print(jsonData['data']);
    } else {
      throw Exception('Failed to load users');
    }
  }
}
