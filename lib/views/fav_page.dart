import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherProvider weatherProviderTrue = Provider.of<WeatherProvider>(context);
    WeatherProvider weatherProviderFalse =
    Provider.of<WeatherProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Favorite Cities',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 26),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 34,),
          Expanded(
            child: ListView.builder(
              itemCount: weatherProviderTrue.weather.length,
              itemBuilder: (context, index) {
                final name = weatherProviderTrue.weather[index]
                    .split('-')
                    .sublist(0, 1)
                    .join('-');
                final temp = weatherProviderTrue.weather[index]
                    .split('-')
                    .sublist(1, 2)
                    .join('-');
                final status = weatherProviderTrue.weather[index]
                    .split('-')
                    .sublist(2, 3)
                    .join('-');
                return Card(
                  color: Color(0xff87A0C9),
                  child: ListTile(
                    title: Text('${name}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 24)),
                    subtitle: Text('${status}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 21)),
                    trailing: Text('${temp}°C',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 38)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}