import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forumapp/models/MensagemBD.dart';
import 'package:forumapp/models/UsuarioBD.dart';
import 'cadastrar.dart';
import 'logar.dart';
import 'mensagem.dart';

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
  
  List<Mensagem> lMensagem = List();
  MensagemHelper helper = MensagemHelper();
  @override
  void initState() {
    super.initState();
    
    if (widget.a == null) {
      _nameController = "Usuario Não Esta Logado";
     
    } else {
      _editedContact = Usuario.fromMap(widget.a.toMap());
      _nameController = _editedContact.name;
      _emailController = _editedContact.email;
      
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
                  radius: 30.0,
                  backgroundImage: 
                NetworkImage(
                  'https://w7.pngwing.com/pngs/406/844/png-transparent-computer-icons-person-user-spark-icon-people-share-icon-user.png'),
                  backgroundColor: Colors.transparent,
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
                      Text(lMensagem[index].nome ?? "",
                          style: TextStyle(fontSize: 14.0)),
                      Padding(
                        padding: EdgeInsets.only(left: 150.0),
                      child:TextButton(                  
                        child: const Text('Ler Toda Mensagem'),
                        onPressed: () {/* ... */},
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
          //_showContactPage(contact: contacts[index]);
         // _showOptions(context, index);
        });
  }

  
}