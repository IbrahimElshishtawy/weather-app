import 'package:flutter/material.dart';

class Searchpage extends StatelessWidget {
  const Searchpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 216, 144, 26),
        title: const Text('Search Page'),
        centerTitle: true,
      ),
      body: Center(
        child: TextField(
          decoration: InputDecoration(
            label: Text('search'),
            contentPadding: EdgeInsets.symmetric(
              vertical: 25.0,
              horizontal: 20,
            ),
            filled: false,

            fillColor: Colors.white,
            hintText: 'Enter city name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
