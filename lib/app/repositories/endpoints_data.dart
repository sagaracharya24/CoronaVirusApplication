import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:coronavirus_tracker/app/services/endpoint_data.dart';

class EndPoinsData {
  final Map<Endpoint, EndpointData> values;

  EndPoinsData({this.values});
  EndpointData get cases => values[Endpoint.cases];
  EndpointData get casesSuspected => values[Endpoint.casesSuspected];
  EndpointData get casesConfirmed => values[Endpoint.casesConfirmed];
  EndpointData get deaths => values[Endpoint.deaths];
  EndpointData get recovered => values[Endpoint.recovered];

  @override
  String toString() =>
      'cases $cases, suspected : $casesSuspected, confirmed : $casesConfirmed, deaths : $deaths , recovered : $recovered ';
}
