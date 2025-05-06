import 'package:flutter/material.dart';
import 'package:weather/screenpage/searchpage.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,

        title: const Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Action for settings button
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Searchpage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('Welcome to the Weather App!', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
