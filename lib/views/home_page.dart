import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/views/fav_page.dart';

TextEditingController txtsearch = TextEditingController();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvidertrue =
        Provider.of<HomeProvider>(context, listen: true);
    HomeProvider homeProviderfalse =
        Provider.of<HomeProvider>(context, listen: false);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: homeProviderfalse.fromMap(homeProvidertrue.search),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModal? weather = snapshot.data;

              return Container(
                height: h,
                width: w,
                decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          weather?.currentModal.is_day == 1 ? Day : Night),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 100,
                        width: w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: TextField(
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                controller: txtsearch,
                                onSubmitted: (value) {
                                  homeProviderfalse.Searchweather(
                                      txtsearch.text);
                                },
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  prefix: const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                  ),
                                  hintText: ('Search Your City'),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 3)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            InkWell(
                                onTap: () {
                                  homeProviderfalse.addFavCity(
                                    weather!.locationModal.name,
                                    weather.currentModal.temp_c.toString(),
                                    weather.currentModal.condition.text,
                                  );
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailScreen()));
                                },
                                child: Icon(
                                  weather?.locationModal.name != 0
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: weather?.locationModal.name != 0
                                      ? Colors.red
                                      : Colors.white,
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        weather!.locationModal.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${weather.currentModal.temp_c.toString()}' + '°C',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 60),
                      ),
                      Text(
                        '${weather.currentModal.condition.text}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.white12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  '${weather.locationModal.name}, ${weather.locationModal.region},',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '${weather.locationModal.country} | ${weather.locationModal.localtime}',
                                  style:
                                      const TextStyle(height: 3, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.white12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: const Text(
                                  'Current Weather',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '${weather.locationModal.country}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: Image.network(
                                  'https:${weather.currentModal.condition.icon}',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const Text('Temp',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(
                                            '${weather.currentModal.temp_c} °C',
                                            style:
                                                const TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text('Feels Like',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(
                                            '${weather.currentModal.temp_f} °C',
                                            style:
                                                const TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text('Humidity',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(
                                            '${weather.currentModal.humidity} %',
                                            style:
                                                const TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.watch_later,
                                    size: 20,
                                    color: Colors.white70,
                                  ),
                                  Text(
                                    ' 24 - Hour Forecast',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 18),
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
                                      weather.forecastModal.forecastDay.first
                                          .hour.length, (index) {
                                    final hour = weather.forecastModal
                                        .forecastDay.first.hour[index];
                                    return Container(
                                        height: 120,
                                        width: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${hour.time.split(" ").sublist(1, 2).join(" ")}',
                                              style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 18),
                                            ),
                                            Image.network(
                                                'https:${hour.hourConditionModal.icon}'),
                                            Text(
                                              '${hour.temp_c}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ));
                                  })
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            height: 150,
                            width: 180,
                            decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Wind Speed',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '${weather.currentModal.wind_kph}' + 'Kph',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                                Text(
                                  '${weather.currentModal.wind_mph}' + 'mph',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            height: 150,
                            width: 170,
                            decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                const Text(
                                  'Humidity',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 28),
                                ),
                                Text(
                                  '${weather.currentModal.humidity}' + '%',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 36),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.hasError.toString()));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

String Day =
    "https://img.freepik.com/free-photo/3d-render-house-countryside_1048-13116.jpg?t=st=1733211962~exp=1733215562~hmac=bde9c1249e4072558be15f551a73ebcb26b49fc5895a6c63857513a3fc47830b&w=1380";
String Night =
    "https://img.freepik.com/free-photo/palm-trees-wallpaper_400718-2.jpg?t=st=1733211788~exp=1733215388~hmac=00bccf8dc0fd45a09c6409c4479921bb9d47ba47946c2c4ccb1aca8fc49195b0&w=1380";
int selectedIndex = 0;
