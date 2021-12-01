import 'package:flutter/material.dart';
import 'package:forumapp/views/page_forum.dart';


void main() {
  runApp(MaterialApp(
    home: PageForum(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({ key }) : super(key: key);

 

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routes = <String, WidgetBuilder> {
     'PageForum': (context) => PageForum(),
  };


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Forum",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: PageForum(),
      routes: routes,
    );
  }
}