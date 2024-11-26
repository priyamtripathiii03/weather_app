import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/provider/weather_provider.dart';

TextEditingController txtSearch = TextEditingController();

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
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 20,
                  fit: BoxFit.cover,
                  image: AssetImage(
                      (weatherProviderTrue.weatherModal!.currentModal.is_day ==
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
                    height: 34,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: txtSearch,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(4),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            hintText: 'Search City Weather',
                            hintStyle: const TextStyle(color: Colors.white),
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
                                )),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            weatherProviderFalse.searchCity(txtSearch.text);
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          '${weatherProviderTrue.weatherModal!.currentModal
                              .temp_c}°C',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 70),
                        ),
                      ),
                      Text('${weatherProviderTrue.weatherModal!.currentModal
                          .condition.text}',
                        style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${weatherProviderTrue.weatherModal!.locationModal.name}, ${weatherProviderTrue.weatherModal!.locationModal.country}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Container(
                        height: 178,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.watch_later,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    ' 24 - Hour Forecast',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(
                                    weatherProviderTrue
                                        .weatherModal!
                                        .forcatModal
                                        .forcastday
                                        .first
                                        .hour
                                        .length,
                                        (index) {
                                      final hour = weatherProviderTrue
                                          .weatherModal!
                                          .forcatModal
                                          .forcastday
                                          .first
                                          .hour[index];
                                      return Container(
                                        height: 120,
                                        width: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${hour.time.split(" ").sublist(
                                                  1, 2).join(" ")}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            Image.network(
                                                'https:${hour.hourConditionModal
                                                    .icon}'),
                                            Text(
                                              '${hour.temp_c}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 150,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${weatherProviderTrue.weatherModal!
                                            .currentModal.wind_mph} mp/h',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      Text(
                                        '${weatherProviderTrue.weatherModal!
                                            .currentModal.wind_kph}kp/h',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                Container(
                                  height: 70,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${weatherProviderTrue.weatherModal!
                                            .forcatModal.forcastday[0].astro
                                            .sunrise} sunrise',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                      Text(
                                        '${weatherProviderTrue.weatherModal!
                                            .forcatModal.forcastday[0].astro
                                            .sunset} sunset',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 207,
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Humidity',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                                '${weatherProviderTrue
                                                    .weatherModal!.currentModal
                                                    .humidity}%',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Divider(
                                          height: 0.2,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'UV',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                                '${weatherProviderTrue
                                                    .weatherModal!.currentModal
                                                    .uv}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        const Divider(
                                          height: 0.2,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Pressure',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                                '${weatherProviderTrue
                                                    .weatherModal!.currentModal
                                                    .pressure_mb}',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        const Divider(
                                          height: 0.2,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Chance of rain',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                                '${weatherProviderTrue
                                                    .weatherModal!.forcatModal
                                                    .forcastday[0].day
                                                    .daily_chance_of_rain}%',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          weatherProviderFalse.addFavCity(
                            weather!.locationModal.name,
                            weather.currentModal.temp_c.toString(),

                            weather.currentModal.condition.text,
                          );
                          Navigator.of(context).pushNamed('fav');
                        },
                        child: Container(
                          height: 52,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Add city to favorite',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
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
        },
      ),
    );
  }
}

String Day =
    'assets/back.jpg';
String Night =
    'assets/night.jpg';