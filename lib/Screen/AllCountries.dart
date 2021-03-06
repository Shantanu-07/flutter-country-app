import 'package:country_house/Screen/Country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllCountries extends StatefulWidget {
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  Future<List> countries;
  bool isSearching = false;
  Future<List> getCountries() async {
    var response = await Dio().get('https://restcountries.eu/rest/v2/all');
    return response.data;
  }

  @override
  void initState() {
    countries = getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: !isSearching
              ? Text('All Countries')
              : TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: 'Search Country here',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
          backgroundColor: Colors.green,
          actions: [
            isSearching
                ? IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        this.isSearching = false;
                      });
                    })
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        this.isSearching = true;
                      });
                    }),
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: FutureBuilder<List>(
              future: countries,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Country(snapshot.data[index]),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          child: Text(
                            snapshot.data[index]['name'],
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  });
                }
                return null;
              },
            )
            // ListView(
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.of(context).push(
            //           MaterialPageRoute(
            //             builder: (context) => Country("India"),
            //           ),
            //         );
            //       },
            //       child: Card(
            //         elevation: 10,
            //         child: Padding(
            //           padding:
            //               const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            //           child: Text(
            //             'India',
            //             style: TextStyle(fontSize: 18),
            //           ),
            //         ),
            //       ),
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.of(context).push(
            //           MaterialPageRoute(
            //             builder: (context) => Country("Canada"),
            //           ),
            //         );
            //       },
            //       child: Card(
            //         elevation: 10,
            //         child: Padding(
            //           padding:
            //               const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            //           child: Text(
            //             'Canada',
            //             style: TextStyle(fontSize: 18),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // )),
            ));
  }
}
