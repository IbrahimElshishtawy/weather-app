//import 'package:flutter/material.dart';
//import 'package:weather/screenpage/homepage.dart';

void main() {
  //  runApp(const MyApp());
  print("hello world");
  print(createordermessage());
  print('hihihihihih');
  print('hihihihihih');
}

Future<String> createordermessage() async {
  var order = await fetchuserorder();
  return 'your order is $order';
}

Future<String> fetchuserorder() =>
    Future.delayed(const Duration(seconds: 2), () => 'large latte');

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(

//       debugShowCheckedModeBanner: false,
//       title: 'Weather App',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const Homepage(),
//     );
//   }
// }
