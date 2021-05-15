import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/brew.dart';
import 'package:flutter_firebase/screens/home/brew_list.dart';
import 'package:flutter_firebase/screens/home/settings_form.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DataBaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text(" Brew Crew"),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(Icons.settings),
              label: Text("Settings"),
            ),
            FlatButton.icon(
              onPressed: () async {
                await _authService.signOut();
              },
              label: Text("Logout"),
              icon: Icon(Icons.person),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'), fit: BoxFit.cover),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
