import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text(" Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await _authService.signOut();
            },
            label: Text("Logout"),
            icon: Icon(Icons.person),
          )
        ],
      ),
    );
  }
}
