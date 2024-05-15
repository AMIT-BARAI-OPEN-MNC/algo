import 'package:algo/view/home.dart';
import 'package:algo/viewmodel/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Wrap MaterialApp with MultiProvider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterModel(context)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sorting Algo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Home(), // Capitalize the first letter of the widget name
      ),
    );
  }
}
