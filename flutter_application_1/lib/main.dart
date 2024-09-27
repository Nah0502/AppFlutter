import 'package:flutter/material.dart';
import './pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        title: 'Flutter Démo',
        theme: ThemeData(
          primarySwatch: Colors.blue
          ),
          home: const HomePage(),
          debugShowCheckedModeBanner: false,
    );
  }
}