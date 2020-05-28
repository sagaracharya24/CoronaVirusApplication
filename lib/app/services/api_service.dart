import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:http/http.dart' as http;


class APIService{
  final API api;

  APIService(this.api);

  Future<String> getAccessToeken() async{

    final response = await http.post(
      api.tokenUri().toString()
    );

  }
}