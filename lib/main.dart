
import 'package:flutter/material.dart';
import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:flutter_poke/pokemon.dart';
import 'package:flutter_poke/pokeDetail.dart';


void main() =>runApp(
  MaterialApp(

      title: "Pokeman App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: HomePage()
  ),
);
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { var url =
    "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
PokeHub pokeHub;
void initState(){

  super.initState();
  fetchData();
}
fetchData() async {
  var res = await http.get(url);
  var decodedJson = jsonDecode(res.body);
  pokeHub = PokeHub.fromJson(decodedJson);
  setState(() {});
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,

      title: Text("Poke App"),
    ),
    floatingActionButton:FloatingActionButton(onPressed: (){},
      child: Icon(Icons.category),),
    drawer: Drawer(),
    body: pokeHub == null
        ? Center(
      child: CircularProgressIndicator(),
    )
        : GridView.count(
      crossAxisCount: 2,
      children: pokeHub.pokemon.map((Pokemon poke)=>Padding(
        padding: const EdgeInsets.all(3.0),
        child: InkWell(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => pokeDetail(
                      pokemon: poke,
                    )));

          },
          child: Card(
            elevation: 3.0,
            child: Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Hero(
                  tag: poke.img,
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(poke.img)),
                    ),
                  ),
                ),
                Text(poke.name,style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
          ),
        ),
      )).toList(),
    ),
  );
}
}
