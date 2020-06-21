import 'package:coronavirus_tracker/app/repositories/data_repository.dart';
import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:coronavirus_tracker/app/services/api_service.dart';
import 'package:coronavirus_tracker/app/services/data_cache_service.dart';
import 'package:coronavirus_tracker/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({Key key, @required this.sharedPreferences}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(
          API.sandbox(),
        ),
        dataCacheService:
            DataCacheService(sharedPreferences: sharedPreferences),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coronavirus Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0XFF101010),
          cardColor: Color(0XFF222222),
        ),
        home: DashBoard(),
      ),
    );
  }
}
