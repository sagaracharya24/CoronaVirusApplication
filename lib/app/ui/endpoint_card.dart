import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EndpointCardData {
  final String title;
  final String assetName;
  final Color color;

  EndpointCardData(this.title, this.assetName, this.color);
}

class EndPointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int value;

  const EndPointCard({Key key, this.endpoint, this.value}) : super(key: key);

  static Map<Endpoint, EndpointCardData> _cardsData = {
    Endpoint.cases:
        EndpointCardData('Cases', 'assets/count.png', Color(0xfffff492)),
    Endpoint.casesSuspected: EndpointCardData(
        'Suspected cases', 'assets/suspect.png', Color(0XFFEEDA28)),
    Endpoint.casesConfirmed: EndpointCardData(
        'Confirmed cases', 'assets/fever.png', Color(0XFFE99600)),
    Endpoint.deaths:
        EndpointCardData('Deaths', 'assets/death.png', Color(0XFFE40000)),
    Endpoint.recovered:
        EndpointCardData('Recovered', 'assets/patient.png', Color(0XFF70A901)),
  };

  String get formattedValue {
    if (value == null) {
      return '';
    }
    return NumberFormat('#,###,###,###').format(value);
  }

  @override
  Widget build(BuildContext context) {
    final cardData = _cardsData[endpoint];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                cardData.title,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: cardData.color),
              ),
              SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      cardData.assetName,
                      color: cardData.color,
                    ),
                    Text(
                      formattedValue,
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: cardData.color, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
