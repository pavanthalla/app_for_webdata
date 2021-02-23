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
  Map mapResponse;

  List listforFacts;

  String si = "https://thegrowingdeveloper.org/apiview?id=1";
  String si1 = "https://thegrowingdeveloper.org/apiview?id=4";
  String si2 = "https://thegrowingdeveloper.org/apiview?id=2";

  Future fetchData() async {
    http.Response response;

    response = await http.get(Uri.encodeFull(si2));
    if (response.statusCode == 200) {
      setState(() {
        //FOR STRING "stringResponse=response.body"
        //FOR LIST  "listResponse=json.decode(response.body)"  before that add "import 'dart:convert';"
        mapResponse = json.decode(response.body);
        listforFacts = mapResponse['facts'];
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
      body: mapResponse == null
          ? Container()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    mapResponse['category'].toString(),
                    style: TextStyle(fontSize: 25),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    //For Scrolling
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text(
                              listforFacts[index]['title'].toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              listforFacts[index]['description'].toString(),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            //Showing error for http connections
                            Image.network(listforFacts[index]['image_url'])
                          ],
                        ),
                      );
                    },
                    itemCount: listforFacts == null ? 0 : listforFacts.length,
                  ),
                ],
              ),
            ),
    );
  }
}
