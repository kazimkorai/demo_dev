import 'package:http/http.dart' as http;

class Request {
  final Uri url;
  final dynamic body;
  final dynamic headers;

  Request({required this.url, this.body, this.headers});
  Future<http.Response> post() {
    return http.post(url, body: body, headers: headers).timeout(Duration(minutes: 2));
  }
  Future<http.Response> get() {
    print('***'+url.toString());
    return http.get(url, headers: headers).timeout(Duration(minutes: 2));
  }
}