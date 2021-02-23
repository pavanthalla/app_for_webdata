import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() => runApp(MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

//stful
//Response Codes 200 for  request succesful,500 internal server error,404 Error not found
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String stringResponse;
  List listResponse;

  String si = "https://thegrowingdeveloper.org/apiview?id=1";
  String si1 = "https://thegrowingdeveloper.org/apiview?id=4";

  Future fetchData() async {
    http.Response response;

    response = await http.get(Uri.encodeFull(si1));
    if (response.statusCode == 200) {
      setState(() {
        //FOR STRING "stringResponse=response.body"
        //FOR LIST  "listResponse=json.decode(response.body)"  before that add "import 'dart:convert';"
        listResponse = json.decode(response.body);
      });
    }
    //or also
    //http.get('https://thegrowingdeveloper.org/apiview?id=1');
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetching Data from Web(Internet)'),
        backgroundColor: Colors.teal[900],
      ),
      body: listResponse == null
          ? Container()
          : Text(
              listResponse.toString(),
              style: TextStyle(fontSize: 25),
            ),
    );
  }
}
