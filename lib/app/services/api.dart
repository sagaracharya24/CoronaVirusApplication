import 'package:coronavirus_tracker/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

class API {
  final String apikey;

  API({@required this.apikey});

  factory API.sandbox() => API(apikey: APIKeys.ncovSandboxKey);

  static final String host = "https://apigw.nubentos.com";
  static final int port = 443;

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: 'token',
        queryParameters: {'grant_type': 'client_credentials'},
      );
}
