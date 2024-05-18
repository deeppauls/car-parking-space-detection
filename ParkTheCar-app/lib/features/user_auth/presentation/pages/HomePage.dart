import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_pageapp/features/user_auth/presentation/pages/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:login_pageapp/features/user_auth/presentation/pages/model.dart';
import 'package:login_pageapp/features/user_auth/presentation/pages/spacesPage.dart';

String stringResponse = "";
Map mapResponse = {};

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TimeOfDay? selectedEntryTime = TimeOfDay.now();
  TimeOfDay? selectedExitTime = TimeOfDay.now();
  List<SpaceCounter> spaceCounter = [];
  Future apiCall() async {
    http.Response respone;
    respone = await http
        .get(Uri.parse("https://ee8d-103-106-200-60.ngrok-free.app/spaces"));
    if (respone.statusCode == 200) {
      setState(() {
        // stringResponse = respone.body;
        mapResponse = json.decode(respone.body);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Color mainColor = Color(0xfff1faee);
    // Color cardColor = Theme.of(context).cardColor;
    // Color timeColor = Theme.of(context).canvasColor;
    return Scaffold(
      // backgroundColor: mainColor,
      appBar: AppBar(
        // backgroundColor: mainColor,
        actions: [
          DropdownButton(
            underline: Container(),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (value) {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              }
            },
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
          )
        ],
        centerTitle: true,
        title: Text("ParkTheCar"),
      ),

      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       Center(
      //         child: Text(
      //           "ParkTheCar",
      //           style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 15,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 20),
      //         child: Text(
      //           'Logout',
      //           style: TextStyle(fontSize: 18),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // FutureBuilder(
                  //   future: getData(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       return Text("${spaceCounter[0].spaces}");
                  //     } else {
                  //       return Text('null');
                  //     }
                  //   },
                  // ),
                  // Text(mapResponse['spaces'].toString()),
                  Text(
                    "Hi There!",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Select your\ntype of vehicle",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => {},
                      borderRadius: BorderRadius.circular(15),
                      child: Card(
                        color: Colors.white,
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Column(
                            children: [
                              Image.asset(
                                "images/carIcon.png",
                                width: 90,
                                height: 90,
                              ),
                              Text("Car"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => {},
                      borderRadius: BorderRadius.circular(15),
                      child: Card(
                        color: Colors.white,
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Column(
                            children: [
                              Image.asset(
                                "images/bikeIcon.png",
                                width: 85,
                                height: 90,
                              ),
                              Text("Bike"),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    "Select the entry time: ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _selectEntryTime(context),
                    child: Text("${selectedEntryTime!.format(context)}"),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text("Select the exit time: ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        // backgroundColor: timeColor,
                        ),
                    onPressed: () => _selectExitTime(context),
                    child: Text("${selectedExitTime!.format(context)}"),
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, SpacesPage.routeName);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Check Spaces',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Center(
      //       child: Text("welcome to home"),

      //     ),
      //     SizedBox(height: 20,),
      //     GestureDetector(
      //       onTap: (){
      //         FirebaseAuth.instance.signOut();
      //         Navigator.pushNamed(context, LoginPage.routeName);

      //       },
      //       child: Container(
      //         height: 45,
      //         width: 100,
      //         decoration: BoxDecoration(
      //           color: Colors.black,
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         child: Center(child: Text(" wanna Sign out baby, touch me?", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
      //       ),
      //     )

      //   ],
      // ),
    );
  }

  Future<void> _selectEntryTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: selectedEntryTime!,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });
    if (picked_s != null && picked_s != selectedEntryTime)
      setState(() {
        selectedEntryTime = picked_s;
      });
  }

  Future<void> _selectExitTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: selectedExitTime!,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });
    if (picked_s != null && picked_s != selectedExitTime)
      setState(() {
        selectedExitTime = picked_s;
      });
  }

  Future<List<SpaceCounter>> getData() async {
    final response = await http
        .get(Uri.parse('https://ee8d-103-106-200-60.ngrok-free.app/spaces'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        spaceCounter.add(SpaceCounter.fromJson(index));
      }
      return spaceCounter;
    } else {
      return spaceCounter;
    }
  }
}
