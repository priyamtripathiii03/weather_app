import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather_app/views/home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomeScreen()));
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 400),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                  // color: Colors.red,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/logo.png'),
                    ),
                ),
              ),
            ),
            Text("Weather Forecast",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
