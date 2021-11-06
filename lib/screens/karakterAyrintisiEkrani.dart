import 'dart:convert';
import 'package:breakingbad/functions/card.dart';
import 'package:breakingbad/models/karakter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class Ayrinti extends StatefulWidget {
  late final int id;

  Ayrinti({required this.id});

  @override
  _AyrintiState createState() => _AyrintiState();
}

class _AyrintiState extends State<Ayrinti> {
  Karakter k = new Karakter();
  bool yukleniyor = false;
  void karakterGetir() async {
    //print(widget.id);
    Response res;

       res = await get(
    Uri.parse('https://breakingbadapi.com/api/characters/${widget.id}'));
  
   
    var data = await jsonDecode(res.body);
    setState(() {
      k.ad = data[0]['name'];
      k.img=data[0]['img'];
      k.id=data[0]['char_id'];
      k.oyuncu=data[0]['portrayed'];
      k.takmaAd=data[0]['nickname'];
      k.durum=data[0]['status'];
      k.dogumGun=data[0]['birthday'];
      yukleniyor = true;
    });
  }

  @override
  void initState() {
    super.initState();
    karakterGetir();
  }

  @override
  Widget build(BuildContext context) {
    return yukleniyor == false
        ? Scaffold(
            body: Center(
              child: SpinKitPulse(
                color: Colors.black,
                size: 150,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TyperAnimatedTextKit(text: ['${k.ad}',
              ],
              repeatForever: true,
              speed: Duration(milliseconds: 200),
              textStyle: TextStyle( fontSize: 25,fontStyle: FontStyle.italic),)
                
              
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(child: 
                Image(
                  image: NetworkImage(k.img),
                  height: 200,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  

                ),
                ),
                SizedBox(
                  height: 10,
                  width: 250,
                  child: Divider(
                    color: Theme.of(context).accentColor,
                  ),
                ),
               cardOlusturucu('İsim : ', k.ad, context),
               cardOlusturucu('Oyuncu : ', k.oyuncu, context),
               cardOlusturucu('Takma ad : ', k.takmaAd, context),
               cardOlusturucu('Doğum günü : ', k.dogumGun, context),
               cardOlusturucu('Durum : ', k.durum, context),
               
                
                

              ],
            ),
          );
  }
}
