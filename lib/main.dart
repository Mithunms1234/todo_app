import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Entry_page.dart';
import 'Note_Home.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences =await  SharedPreferences.getInstance();
 bool? logged = await sharedPreferences.getBool("looged");
  runApp( MyApp(islogged: logged,));
}
class MyApp extends StatelessWidget {
  bool? islogged;
   MyApp({Key? key,required this.islogged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      primarySwatch: Colors.green,
    ),
      home: islogged == true ?  home_note():Entry(),
    );
  }
}
