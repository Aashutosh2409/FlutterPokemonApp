import 'package:flutter/material.dart';
import 'package:poke_app/json_dart_poke.dart';

//nothing to render dynamically...
class PokeDetails extends StatelessWidget {
  final Pokemon pokemon;

  //passing through constructor...
  PokeDetails({this.pokemon});

  bodyWidget(BuildContext context)=>Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height/1.3,
        width: MediaQuery.of(context).size.width-20,
        left:10,
        top:MediaQuery.of(context).size.height*0.1,

        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
          ),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              SizedBox(
                height: 50.0,
              ),

              Text(pokemon.name,style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold ),),
              Text("Height: ${pokemon.height}"),
              Text("Weight: ${pokemon.weight}"),
              Text("Types: "),
              Row(
                //space between two child in row....
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.type.map((f)=>FilterChip(
                    label:Text(f),
                    backgroundColor: Colors.green,
                    onSelected: (b){}))
                    .toList(),
              ),
              Text("Weakness: "),
              Row(
                //space between two child in row....
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.weaknesses
                    .map((f)=>FilterChip(
                    label:Text(f,
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.red,
                    onSelected: (b){}))
                    .toList(),
              ),
            ],
          ),
        ),
      ),

      Align(
        alignment: Alignment.topCenter,
        child: Hero(tag: pokemon.img,child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(pokemon.img),
                fit:BoxFit.cover),
          ),
        )
        ),
      )

    ],
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.cyan,
    appBar:AppBar(
      centerTitle:true,
      backgroundColor: Colors.cyan,
      title: Text(pokemon.name),
      elevation: 0.0,
    ),

      body: bodyWidget(context),

    );
  }
}
