import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/crud.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String playerName;
  String position;

  QuerySnapshot players;

  crudMethods crudObj = new crudMethods();

   Future<bool> addDialog(BuildContext context) async{
      return showDialog(
         context: context,
          barrierDismissible: false,
           builder: (BuildContext context){
              return AlertDialog(
                 title: Text('Add Players', style:  TextStyle( fontSize: 16.0),),
               content: Column(
                  children: <Widget>[
                     TextField(
                        decoration: InputDecoration(
                           hintText: 'Enter Player Name',
                        ),
                         onChanged: (value){
                            this.playerName = value;
                         },
                     ),
                     SizedBox( height: 5.0,),
                       TextField(
                        decoration: InputDecoration(
                           hintText: 'Enter Player Position',
                        ),
                         onChanged: (value){
                            this.position = value;
                         },
                     ),
                  ],
               ),
                actions: <Widget>[
                   FlatButton(
                     child: Text('Add'),
                      textColor: Colors.blue,
                       onPressed: (){
                          Navigator.of(context).pop();
                           Map playerData = {'playerName' : this.playerName, 'position': this.position};
                          crudObj.addData(playerData).then((result){
                             dialogTrigger(context);
                          }).catchError((e){
                            print(e);
                          });
                       },
                   ),
                ],
              );
           }

      );
   }

    Future<bool> dialogTrigger(BuildContext context) async{
     return showDialog(
        context: context,
         barrierDismissible: false,
          builder: (BuildContext context){
             return AlertDialog(
                title:  Text('JOB Done', style: TextStyle( fontSize: 15.0),),
                 content:  Text('Player Added'),
                 actions: <Widget>[
                    FlatButton(
                       child:  Text('Alright cool'),
                       textColor: Colors.blue,
                       onPressed: () {
                         Navigator.of(context).pop();
                       },
                    )
                 ],

             );
          }
     );
    }

    @override
    void initState(){
      crudObj.getData().then((results){
         setState(() {
                    players = results;
                  });
      });
    }
  @override
  Widget build(BuildContext context) {
     
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       theme: ThemeData(
          brightness: Brightness.dark
       ),
    home: Scaffold(
        
       appBar:  AppBar(
          title: Text('Dashboard', style: TextStyle( color: Colors.white),),
          actions: <Widget>[
             IconButton(
                icon:  Icon(Icons.add),
                 onPressed: (){
                   addDialog(context);
                 },
             )
          ],
       ),
      body: Center(),
      
    ),
    );
  }
}