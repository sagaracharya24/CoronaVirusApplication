import 'package:coronavirus_tracker/app/repositories/endpoints_data.dart';
import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:coronavirus_tracker/app/services/api_service.dart';
import 'package:coronavirus_tracker/app/services/data_cache_service.dart';
import 'package:coronavirus_tracker/app/services/endpoint_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiService, @required this.dataCacheService});
  final APIService apiService;

  final DataCacheService dataCacheService;
  String _accessToken;

  Future<EndpointData> getEndPointData(Endpoint endpoint) async =>
      await _getDataRefreshingToken<EndpointData>(
          onGetData: () => apiService.getEndPointData(
              accessToken: _accessToken, endpoint: endpoint));

  EndPoinsData getAllEndpointsCachedData() => dataCacheService.getData();

  Future<EndPoinsData> getAllEndPointsData() async {
    final endpointsData = await _getDataRefreshingToken<EndPoinsData>(
      onGetData: _getAllEndPointsData,
    );

    await dataCacheService.setData(endpointsData);
    return endpointsData;
  }

  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }

      return await onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<EndPoinsData> _getAllEndPointsData() async {
    final values = await Future.wait([
      apiService.getEndPointData(
          accessToken: _accessToken, endpoint: Endpoint.cases),
      apiService.getEndPointData(
          accessToken: _accessToken, endpoint: Endpoint.casesSuspected),
      apiService.getEndPointData(
          accessToken: _accessToken, endpoint: Endpoint.casesConfirmed),
      apiService.getEndPointData(
          accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiService.getEndPointData(
          accessToken: _accessToken, endpoint: Endpoint.recovered),
    ]);
    return EndPoinsData(values: {
      Endpoint.cases: values[0],
      Endpoint.casesSuspected: values[1],
      Endpoint.casesConfirmed: values[2],
      Endpoint.deaths: values[3],
      Endpoint.recovered: values[4],
    });
  }
}
