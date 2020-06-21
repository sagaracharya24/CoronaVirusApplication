import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class LastUpdatedDateFormatter {
  final DateTime lastUpdated;

  LastUpdatedDateFormatter({this.lastUpdated});

  String lastupdatedStatusText() {
    if (lastUpdated != null) {
      final formatter = DateFormat.yMd().add_Hms();
      String formated = formatter.format(lastUpdated);
      return 'Last updated : $formated';
    }
    return '';
  }
}

class LastUpdatedStatusText extends StatelessWidget {
  final String text;

  const LastUpdatedStatusText({Key key, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
