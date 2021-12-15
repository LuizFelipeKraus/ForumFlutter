import 'package:flutter/material.dart';
import 'package:forumapp/models/MensagemBD.dart';
import 'package:forumapp/models/UsuarioBD.dart';
import 'package:forumapp/views/page_forum.dart';
import 'logar.dart';

class Mensagem_especifica extends StatefulWidget {
  
  final Mensagem mensagem;

  Mensagem_especifica({this.mensagem});
  

  @override
  _Mensagem_especificaState createState() => _Mensagem_especificaState();
}

class _Mensagem_especificaState extends State<Mensagem_especifica> {
  Mensagem _editedContact;

  void initState() {
    super.initState();
      _editedContact = Mensagem.fromMap(widget.mensagem.toMap());
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title:  Text(_editedContact.titulo ?? ""),
        centerTitle: true ,
      ),
      backgroundColor: Colors.blue[100],
      body: SingleChildScrollView( child:_body(),)
    );
  }
 
_body(){
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          children: <Widget>[
              Card(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    new Container(
                      alignment: Alignment.center,
                      child:Text(_editedContact.titulo ?? "",                       
                        style: TextStyle(
                        fontSize: 28,                        
                        foreground: Paint()..color = Colors.blueAccent,                        
                        ), 
                      ),
                    ),
                     new Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.topLeft,
                      child:Text("Autor: " + _editedContact.nome ?? "",                       
                        style: TextStyle(
                        fontSize: 15,                        
                        foreground: Paint()..color = Colors.black,                        
                        ), 
                      ),
                    ),
                      
                      new Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.bottomLeft,
                      child:Text(_editedContact.mensagem?? "",                       
                        style: TextStyle(
                        fontSize: 20.0,                        
                        foreground: Paint()..color = Colors.black,                        
                        ), 
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
     );
  }
  
}
