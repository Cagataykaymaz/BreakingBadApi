import 'dart:convert';

import 'package:breakingbad/models/karakter.dart';
import 'package:breakingbad/screens/karakterAyrintisiEkrani.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Karakterler extends StatefulWidget {
  const Karakterler({Key? key}) : super(key: key);

  @override
  _KarakterlerState createState() => _KarakterlerState();
}

class _KarakterlerState extends State<Karakterler> {
  List<Karakter> karakterDizisi = [];

  void karakterlerGetir() async {
    Response res =
        await get(Uri.parse('https://breakingbadapi.com/api/characters'));
    var data = await jsonDecode(res.body);
    setState(() {
      for (var i = 0; i < data.length; i++) {
        Karakter k = Karakter();
        k.id = data[i]['char_id'];
        k.ad = data[i]['name'];
        k.img = data[i]['img'];

        karakterDizisi.add(k);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    karakterlerGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breaking Bad'),
    
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Theme.of(context).backgroundColor,
            Theme.of(context).scaffoldBackgroundColor
          ],
          tileMode: TileMode.mirror,
        )),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(_) => Ayrinti(id: karakterDizisi[index].id)));
              },
              child: ListTile(
                title: Text(
                  karakterDizisi[index].ad,
                  style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 20),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(karakterDizisi[index].img),
                ),
              ),
            );
          },
          itemCount: karakterDizisi.length,
        ),
      ),
    );
  }
}
