import 'dart:convert';
import 'dart:ui';

import 'package:berita_app/detail_berita.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BeritaHome(),
    );
  }
}

class BeritaHome extends StatelessWidget {
  Future<Map<String, dynamic>> getBerita() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=tesla&from=2021-07-06&sortBy=publishedAt&apiKey=be14be3a5ea949858c0c15edca7cd40d"));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Berita Apps")),
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder(
        future: getBerita(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return _showBerita(snapshot.data['articles']);
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error ${snapshot.error.toString()}"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _showBerita(List data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, index) {
        return Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:  BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3.0,
                  ),
                ]),
            child: Card(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PageDetailBerita(data: data[index])));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    '${data[index]['urlToImage']}'),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                              topLeft: Radius.circular(5),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            //    color: Colors.red,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text('${data[index]['title']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                          ),
                        ),
                      ],
                    ),
                ),
            ),
        );
      },
    );
  }
}
