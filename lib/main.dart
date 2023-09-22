import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  //bool nextPage = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        pages: [MaterialPage(child: MyHomePage(title: "Bellows")),],
        onPopPage: (route, result){
         // nextPage = false;
          return route.didPop(result);
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String someText = "Press the mail icon!";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.pink,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Yo',
            ),
            Text(
              'hello',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyNextPage()));
            }, child: Text("press for next page")),
            IconButton(
                onPressed: () async {
                  var url2 = Uri.https('catfact.ninja','fact');
                  var url = Uri.https('italian-jokes.vercel.app', 'api/jokes');
                  var response = await http.get(url2);
                  var jBody = json.decode(response.body);
                  print(jBody['fact']);
                  setState(() {
                    someText = jBody['fact'];
                  });
                },
                icon: Icon(Icons.mail),
                color: Colors.pink,
            ),
            Text(someText)
          ],
        ),
      ),
    );
  }
}
class MyNextPage extends StatefulWidget {
  const MyNextPage({super.key});

  @override
  State<MyNextPage> createState() => _MyNextPageState();
}

class _MyNextPageState extends State<MyNextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("nextpage"),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text("This is my second page"),
            ElevatedButton.icon(onPressed: (){
              Navigator.pop(context);
            },
              icon: Icon(Icons.airline_stops_outlined),
              label: Text("Go back?"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red)
            ),
            Text("And here are some pictures"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/1000animals.jpg",
                width: 60),
                Image.asset("assets/1000nature.jpg",
                    width: 60),
                Image.asset("assets/1000people.jpg",
                    width: 60),
                Image.asset("assets/1000tech.jpg",
                    width: 60)
              ],
            )
          ],
        ),

      ),
    );
  }
}

