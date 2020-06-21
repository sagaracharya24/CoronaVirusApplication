import 'dart:io';

import 'package:coronavirus_tracker/app/repositories/data_repository.dart';
import 'package:coronavirus_tracker/app/repositories/endpoints_data.dart';
import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:coronavirus_tracker/app/services/endpoint_data.dart';
import 'package:coronavirus_tracker/app/ui/endpoint_card.dart';
import 'package:coronavirus_tracker/app/ui/last_updated_status.dart';
import 'package:coronavirus_tracker/app/ui/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  EndPoinsData _endPoinsData;

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endPoinsData = await dataRepository.getAllEndPointsData();
      setState(() {
        _endPoinsData = endPoinsData;
      });
    } on SocketException catch (_) {
      showalertDialog(
          context: context,
          title: 'Connection Error',
          content: 'Could not retrive data. Please try again later',
          defaultActionText: 'Ok');
    } catch (_) {
      // This error is not of type socket exception
      showalertDialog(
          context: context,
          title: 'Unknow Error',
          content: 'Please contact support. Please try again later',
          defaultActionText: 'Ok');
    }
  }

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endPoinsData = dataRepository.getAllEndpointsCachedData(); 
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
        lastUpdated: _endPoinsData != null
            ? _endPoinsData.values[Endpoint.cases]?.date 
            : null);
    return Scaffold(
        appBar: AppBar(
          title: Text('Coronavirus Tracker'),
        ),
        body: RefreshIndicator(
          onRefresh: _updateData,
          child: ListView(
            children: <Widget>[
              LastUpdatedStatusText(text: formatter.lastupdatedStatusText()),
              for (var endpoint in Endpoint.values)
                EndPointCard(
                  endpoint: endpoint,
                  value: _endPoinsData != null
                      ? _endPoinsData.values[endpoint]?.value
                      : null,
                )
            ],
          ),
        ));
  }
}
