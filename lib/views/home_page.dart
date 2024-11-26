import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import '../model/weather_model.dart';

TextEditingController textSearch = TextEditingController();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherProvider weatherProviderTrue = Provider.of<WeatherProvider>(context);
    WeatherProvider weatherProviderFalse =
        Provider.of<WeatherProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
          future: weatherProviderFalse.fromMap(weatherProviderTrue.search),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModal? weather = snapshot.data;
              return Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage((weatherProviderTrue
                                .weatherModal!.currentModal.is_day ==
                            1)
                        ? Day
                        : Night),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: textSearch,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(5),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Search Your City Weather',
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                weatherProviderFalse
                                    .searchCity(textSearch.text);
                              },
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '${weatherProviderTrue.weatherModal!.currentModal.temp_c}°C',
                              style: TextStyle(
                                  fontSize: 70,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${weatherProviderTrue.weatherModal!.currentModal.condition.text}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 70.0),
                          child: Row(
                            children: [
                              Text(
                                '${weatherProviderTrue.weatherModal!.locationModal.name},',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${weatherProviderTrue.weatherModal!.locationModal.region}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

String Day =
    "https://mir-s3-cdn-cf.behance.net/project_modules/max_632/08b82764085127.5ac64c0dae08c.gif";
String Night =
    "https://img.freepik.com/free-photo/starry-sky-town_23-2151642596.jpg?ga=GA1.2.19654575.1717952195&semt=ais_hybrid";
