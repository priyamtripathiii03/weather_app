import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvidertrue =
        Provider.of<HomeProvider>(context, listen: true);
    HomeProvider homeProviderfalse =
        Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Favorite Cities',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 26),
        ),
      ),
      body: ListView.builder(
        itemCount: homeProvidertrue.weather.length,
        itemBuilder: (context, index) {
          final name = homeProvidertrue.weather[index]
              .split('-')
              .sublist(0, 1)
              .join('-');
          final temp = homeProvidertrue.weather[index]
              .split('-')
              .sublist(1, 2)
              .join('-');
          final status = homeProvidertrue.weather[index]
              .split('-')
              .sublist(2, 3)
              .join('-');
          return Card(
            color: const Color(0xff87A0C9),
            child: ListTile(
              title: Text('${name}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 24)),
              subtitle: Text('${status}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 21)),
              leading: Text('${temp}°C',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 38)),
              trailing: InkWell(
                  onTap: () {
                    homeProviderfalse.Delete(index);
                  },
                  child: const Icon(Icons.delete,color: Colors.red,)),
            ),
          );
        },
      ),
    );
  }
}
