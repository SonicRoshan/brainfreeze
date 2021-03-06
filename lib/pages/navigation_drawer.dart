import 'package:flutter/material.dart';
import 'package:brainfreeze/settings/strings.dart';
import 'package:brainfreeze/vulcun_client/vulcun_client.dart';
import 'math_page.dart';
import 'leaderboard_page.dart';


class NavigationDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NavigationDrawerState();
  }
}

class NavigationDrawerState extends State<NavigationDrawer> {
  int _selectedIndex = 0;
  List<String> _pageTitles = [StringsSettings.mathPage, StringsSettings.leaderboardPage];

  void _signOut() async {
    print("signing Out");
    VulcunClient vulcunClient = VulcunClient(null, null);
    await vulcunClient.retreiveData();
    await vulcunClient.signOut();
    Navigator.of(context).pushReplacementNamed(StringsSettings.loginRoute);
  }

  Widget _getDrawerItemSelected(int position){
    Widget page;
     switch (position) {
       case 0:
         page = MathPage();
         break;
       case 1:
         page = LeaderboardPage();
         break;
       case 2:
        _signOut();
     }
     return page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this._pageTitles[this._selectedIndex])
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(height: 80),
            RaisedButton(
              child: Text(StringsSettings.mathPage),
              onPressed: () {
                setState(() {
                 this._selectedIndex = 0; 
                });
              },
            ),
            RaisedButton(
              child: Text(StringsSettings.leaderboardPage),
              onPressed: () {
                setState(() {
                 this._selectedIndex = 1; 
                });
              },
            ),
            RaisedButton(
              child: Text(StringsSettings.signOut),
              onPressed: _signOut,
            )
          ],
        ),
      ),
      body: _getDrawerItemSelected(this._selectedIndex),
    );
  }
  
}