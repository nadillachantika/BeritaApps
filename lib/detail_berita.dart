import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
//
class PageDetailBerita extends StatelessWidget {

  final data;
  PageDetailBerita({this.data});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( '${data['title']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${data['urlToImage']}'),
                  fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
              //  color: Colors.red,
                borderRadius: BorderRadius.circular(30.0),),
              child: Text('${data['title']}', style: TextStyle(fontSize:16.0,color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8.0,
            ),
            Text('${data['description']}',
              style: TextStyle( fontSize: 14.0),

            )
          ],
        ),
      ),

    );

  }
}