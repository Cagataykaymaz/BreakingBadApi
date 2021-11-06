import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cardOlusturucu(String leading,String title,BuildContext context) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
    child: ListTile(
        leading: Text(
          leading,
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
        ),
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).accentColor, fontSize: 25),
        )),
  );
}
