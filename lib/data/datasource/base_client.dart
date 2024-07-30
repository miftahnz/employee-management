import 'package:http/http.dart' as http;

class BaseClient {
  var client = http.Client();

  Future<dynamic> get(String api) async {
    var url = Uri.parse('https://api.thecatapi.com/v1/images/0XYvRd7oD');

    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      
    }
  }

  Future<dynamic> post(String api) async {}

  Future<dynamic> put(String api) async {}

  Future<dynamic> delete(String api) async {}
}
