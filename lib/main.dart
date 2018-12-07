import 'package:flutter/material.dart';

//adding http:^0.12.0 in dependency under pubspec.yaml file.....
import 'package:http/http.dart' as http;
import 'package:poke_app/json_dart_poke.dart';

//to convert
import 'dart:convert';

import 'package:poke_app/pokeDetails.dart';

//method for entry gate...
void main()=>runApp(MaterialApp(
  title: "Poke App",

//  theme: ThemeData(primarySwatch: Colors.cyan
//  ),

  //will direct to first page called HomePage...once open
  home: HomePage(),
  //to remove demo banner...
  debugShowCheckedModeBanner: false,
));

//"stateless" Widget are fixed widgets that doesnt get changed!!
//"stateful" widget get changed frequently...
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {

   var url="https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

   PokeHub pokeHub;

  //we need to declare init state for initializing the application..whenever it gets started
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    //creating a method.....
    fetchData();
  }

  //doing parallel work while busy...
  fetchData() async{
    //we are telling to finish other process while we fetch the url....
    var res = await http.get(url);
    //we will get response...lets try to print
    //print(res.body);
    //to decode the json...
    var decodedValue= jsonDecode(res.body);
    
    pokeHub =PokeHub.fromJson(decodedValue);
    //to test//print(pokeHub);

    //to re-render state on force-start..to refresh..
    setState(() {});

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Pokemon App"),
      ),

      //Main BODY
      //if not null we will show circular progress indicator to the user, if not we will show content....
      body: pokeHub==null?Center(child: CircularProgressIndicator(),):
      GridView.count(
        crossAxisCount: 2,
        children: pokeHub.pokemon.map((Pokemon poke)=> Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell( //we can also use GestureDetector
              //so on tap we need to push on next page..for details..
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PokeDetails(
                  pokemon: poke,
                )
                )
                );
              },
              child: Card(
                elevation: 5.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                  children: <Widget>[
                    Hero(
                      tag: poke.img,
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(poke.img))
                        ),
                      ),
                    ),
                    Text(poke.name, style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
        )).toList(),
      ),

      //it is for menu option..
      drawer: Drawer(),

      //####floating Action Button...###no functionality added yet
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: (){},
        child:Icon(Icons.refresh) ,
      ),
    );
  }
}
