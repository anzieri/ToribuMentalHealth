import "dart:convert";
import "package:app2/requests/loginlogic.dart";
import "package:http/http.dart" as http;

Future<Map<String, dynamic>> postRegisterRequest(
    String url, Map<String, dynamic> data) async {
  try {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print("Request successful");
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send json');
    }
  } catch (error) {
    print('Failed to send json: $error');
    return {"error": error};
  }
}

Future<Map<String, dynamic>> postLoginRequest(
    String url, Map<String, dynamic> data) async {
  try {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print("Request successful");
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send json');
    }
  } catch (error) {
    print('Failed to send json: $error');
    return {"error": error};
  }
}

Future<Map<String, dynamic>> getQuote(String url) async {
  try {
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      print("Request successful");
      List<dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse.isNotEmpty && jsonResponse[0] is Map<String, dynamic>) {
        return jsonResponse[0] as Map<String, dynamic>;
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to send json');
    }
  } catch (error) {
    print('Failed to send json: $error');
    return {"error": error};
  }
}

Future<Map<String, dynamic>> postPreferences(Map<String, dynamic> data) async {
  try {
    final String toki = getToken() ?? '';
    print(toki);
    final response = await http.post(
      Uri.parse("http://localhost:8080/api/v1/preferences/saveUserPreferences"),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $toki'
      },
    );

    if (response.statusCode == 200) {
      print("Request successful");
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send json');
    }
  } catch (error) {
    print('Failed to send json: $error');
    return {"error": error};
  }
}

Future<Map<String, dynamic>> postTherapistSpecifics(
    Map<String, dynamic> data) async {
  try {
    final String toki = getToken() ?? '';
    print(toki);
    final response = await http.post(
      Uri.parse(
          "http://localhost:8080/api/v1/therapistSpecifics/saveTherapistSpecifics"),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $toki'
      },
    );

    if (response.statusCode == 200) {
      print("Request successful");
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send json');
    }
  } catch (error) {
    print('Failed to send json: $error');
    return {"error": error};
  }
}

Future<Map<String, dynamic>> getTherapistSpecifics() async {
  try {
    final String toki = getToken() ?? '';
    print(toki);
    final response = await http.get(
      Uri.parse(
          "http://localhost:8080/api/v1/therapistSpecifics/getTherapistSpecifics"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $toki'
      },
    );

    if (response.statusCode == 200) {
      print("Request successful");
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send json');
    }
  } catch (error) {
    print('Failed to send json: $error');
    return {"error": error};
  }
}

Future<List<dynamic>> findTherapists() async {
  try {
    final String toki = getToken() ?? '';
    print(toki);

    
    final response = await http.get(
      Uri.parse(
          "http://localhost:8080/api/v1/preferences/findTherapistByPreferences"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $toki'
      },
    );

    if (response.statusCode == 200) {
      print("Request successful");
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send json');
    }
  } catch (error) {
    print('Failed to send json: $error');
    return [error];
  }
}

Future<Map<String,dynamic>> saveAppointments(Map<String, dynamic> data) async {
  try {
    final String toki = getToken() ?? '';
    print(toki);
    final response = await http.post(
      Uri.parse("http://localhost:8080/api/v1/appointments/saveAppointment"),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $toki'
      },
    );

    if (response.statusCode == 200) {
      print("Request successful");
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send json');
    }
  } catch (error) {
    print('Failed to send json: $error');
    return {"error": error};
  }
}

Future<List<dynamic>> getAppointments() async {
  try {
    final String toki = getToken() ?? '';
    print(toki);
    final response = await http.get(
      Uri.parse(
          "http://localhost:8080/api/v1/appointments/getAppointments"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $toki'
      },
    );

    if (response.statusCode == 200) {
      print("Request successful");
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send json');
    }
  } catch (error) {
    print('Failed to send json: $error');
    return [error];
  }
}