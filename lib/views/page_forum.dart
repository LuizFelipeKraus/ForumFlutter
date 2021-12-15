import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forumapp/models/MensagemBD.dart';
import 'package:forumapp/models/UsuarioBD.dart';
import 'cadastrar.dart';
import 'logar.dart';
import 'mensagem.dart';
import 'mensagem_especifica.dart';

class PageForum extends StatefulWidget {
  Usuario a;
  PageForum({this.a});
  @override
  _PageForumState createState() => _PageForumState();
}

class _PageForumState extends State<PageForum> {
  String _nameController = "";
  String _emailController = "";
  Usuario _editedContact;
  IconData icon = Icons.cancel_rounded;
  List<Mensagem> lMensagem = List();
  MensagemHelper helper = MensagemHelper();
  @override
  void initState() {
    super.initState();
    
    if (widget.a == null) {
      _nameController = "Usuario Não Esta Logado";
      icon = Icons.cancel_rounded;
    } else {
      _editedContact = Usuario.fromMap(widget.a.toMap());
      _nameController = _editedContact.name;
      _emailController = _editedContact.email;
      icon = Icons.check;
     
    }
    _getAllContacts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Text('FÓRUM'),
        centerTitle: true ,
      ),
      backgroundColor: Colors.blue[100],
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: lMensagem.length,
          itemBuilder: (context, index) {
            return _contactCard(context, index);
          }),
        

      floatingActionButton:  FloatingActionButton.extended(
        onPressed: () {
           if(_nameController == "Usuario Não Esta Logado"){
              _showDialog();
           }else {
             Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MensagemAplicacao(a: _editedContact)),
            );
           }
        },
        label: const Text('ADD'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,            
             
      ),

      drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(               
                accountName: Text( _nameController),
                accountEmail: Text( _emailController ),
                currentAccountPicture: CircleAvatar(                           
                 
                  backgroundColor: Colors.blue[900],
                  child: Icon(                    
                   icon,
                   
                  ),
                    ),
                  ),
                 
              
              ListTile(
                leading: Icon(Icons.account_circle_rounded, color: Colors.blue[600]),
                title: Text("Entrar"),
                subtitle: Text("Clique para fazer login..."),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                }
               ),
               ListTile( 
                 leading: Icon(Icons.add_reaction_sharp, color: Colors.blue[600]),
                 title: Text("Cadastrar"),
                 subtitle: Text("Cadastrar um novo usuário.."),
                 trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cadastro()),
                  );
                }
               ),
                ListTile( 
                 leading: Icon(Icons.logout, color: Colors.blue[600]),
                 title: Text("Deslogar"),
                 subtitle: Text("Clicando aqui você vai deslogar do sitema..."),
                 trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageForum()),
                  );
                }
               )
               
            ],
           )
        )
        
    );
  }
  void _getAllContacts()  {
    helper.getAllContacts().then((list) {
      setState(() {
         lMensagem = list;
      });
      
    });
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,                                        
                    children: <Widget>[
                       Container(
                        
                      child:Text(lMensagem[index].titulo ?? "",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                       ),
                      Text("Autor: " + lMensagem[index].nome ?? "",
                          style: TextStyle(fontSize: 14.0)),
                      Padding(
                        padding: EdgeInsets.only(left: 150.0),
                      child:TextButton(                  
                        child: const Text('Ler Toda Mensagem'),
                        onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Mensagem_especifica(mensagem : lMensagem[index])),
                            );
                        },
                        ), 
                        ), 
                    ],
                    
                  ),
                )
                
              ],
            ),
          ),
        ),
        onTap: () {
         
        }
        );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
      
        return AlertDialog(
          title: new Text("Você Não Está Logado no Sistema"),
          
          actions: <Widget>[
         
            new FlatButton(
              child: new Text("Entrar"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
              },
            ),
            new FlatButton(              
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    }
}