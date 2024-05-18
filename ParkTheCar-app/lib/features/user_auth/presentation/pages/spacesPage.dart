import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SpacesPage extends StatefulWidget {
  static const routeName = "/spaces";
  const SpacesPage({super.key});

  @override
  State<SpacesPage> createState() => _SpacesPageState();
}

int randomNum() {
  Random random = Random();

  int randomNumber = random.nextInt(3) + 13;
  return randomNumber;
}

class _SpacesPageState extends State<SpacesPage> {
  @override
  Widget build(BuildContext context) {
    // Color mainColor = Color(0xffa2d2ff);
    int random = randomNum();
    return Scaffold(
      // backgroundColor: mainColor,
      appBar: AppBar(
          // backgroundColor: mainColor,
          ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black26,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  child: Text(
                    'Available Spaces: ${random}',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 25),
              IconButton(
                  onPressed: () {
                    setState(() {
                      random = randomNum();
                    });
                  },
                  icon: Icon(Icons.refresh, size: 35)),
              SizedBox(height: 8),
              Text('Click on the above refresh button to see the updated data',
                  style: TextStyle(fontSize: 16)),
              // Text(
              //   'Please refresh/reload the page to see the updated data',
              //   style: TextStyle(fontSize: 16),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleRefresh(int random) async {
    // Simulate network fetch or database query
    await Future.delayed(Duration(seconds: 2));
    // Update the list of items and refresh the UI
    setState(() {
      random = randomNum();
    });
  }
}
