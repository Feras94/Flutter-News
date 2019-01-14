import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'World News Application',
                  style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
                ),
                Text(
                  'Stay Updated with the world around you',
                  style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
          ),
          ListTile(
            title: Text('Menu Item 1'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: Text('Menu Item 2'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: Text('Menu Item 3'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
