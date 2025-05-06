import 'package:flutter/material.dart';

class Searchpage extends StatelessWidget {
  const Searchpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Action for settings button
              Navigator.pop(context);
            },
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 216, 144, 26),
        title: const Text('Search Page'),
        centerTitle: true,
      ),
      body: Center(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Enter city name',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
          ),
          onSubmitted: (String value) {
            // Handle search action here
            print('Searching for $value');
          },
        ),
      ),
    );
  }
}
