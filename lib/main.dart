import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Food Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<HomePage> {
  List<dynamic> data=[];
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('FLUTTER FOOD')) ,
    body: Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _Click,
              child: const Text('LOAD FOODS DATA'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                  itemBuilder: (_, index) {
                    return Card(
                       child: Container(
                         child: InkWell(
                           onTap: (){},
                           child: Row(
                             children: [
                               Image.network(data[index]['image'].toString(),width: 100,height: 100,fit: BoxFit.cover),
                               Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(data[index]['name'].toString(),style: TextStyle(fontSize: 20),),
                                     Text(data[index]['price'].toString()+" บาท",style: TextStyle(fontSize: 15),),

                                   ],
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                    );
               }
              ),
            ),

          ],
    ),
      ),
    ),
  );
  
  }
  void _Click() async {
    var CallApi = await http.get(Uri.parse('https://cpsu-test-api.herokuapp.com/foods'));
    var json= jsonDecode(CallApi.body);
    setState(() {
      data=json['data'];

    });

  }
}




