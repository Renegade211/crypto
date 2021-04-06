import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[800],
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Center(
                      child: Text('Profile',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)))),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple[800]),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)))),
                  onPressed: () {
                    print("Pressed");
                  },
                  child: Container(
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Icon(Icons.security_rounded),
                          SizedBox(width: 5),
                          Text(
                            'Security',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ))),
              SizedBox(height: 10),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple[800]),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)))),
                  onPressed: () {
                    print("Pressed");
                  },
                  child: Container(
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Icon(Icons.settings),
                          SizedBox(width: 5),
                          Text(
                            'Settings',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ))),
              SizedBox(height: 10),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple[800]),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)))),
                  onPressed: () {
                    print("Pressed");
                  },
                  child: Container(
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Icon(Icons.help),
                          SizedBox(width: 5),
                          Text(
                            'Help',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ))),
              SizedBox(height: 10),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple[800]),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)))),
                  onPressed: () {
                    print("Pressed");
                  },
                  child: Container(
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Icon(Icons.notifications),
                          SizedBox(width: 5),
                          Text(
                            'Notifications',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ))),
            ],
          ),
        ));
  }
}
