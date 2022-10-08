import 'package:cabavenue_drive/services/token_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DashboardService {
  String? url = dotenv.env['BACKEND_URL_WITH_PORT'];
  final TokenService _tokenService = TokenService();

  dynamic getDashboardReport() async {
    try {
      String id = await _tokenService.getUserId();
      String token = await _tokenService.getToken();
      var dashboard = await http.get(
        Uri.parse('http://$url/v1/users/dashboard/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) => value.body.toString());

      return dashboard;
    } catch (e) {
      print(e);
    }
  }
}
