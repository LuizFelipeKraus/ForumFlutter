import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forumapp/models/UsuarioBD.dart';
import 'package:forumapp/views/page_forum.dart';

class Cadastro extends StatefulWidget {
  final Usuario contact;
  Cadastro({this.contact});
  
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  UsuarioHelper helper = UsuarioHelper();
  Usuario _editedContact;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Usuario();
    } else {
      _editedContact = Usuario.fromMap(widget.contact.toMap());

      nome.text = _editedContact.name;
      email.text = _editedContact.email;
      senha.text = _editedContact.senha;
    }
  }

  void _resetFields() {
    nome.text = "";
    email.text = "";
    senha.text = "";   
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        centerTitle: true ,
        title: Text("CADASTRAR"),
        backgroundColor: Colors.blue[800],
      ),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),

             child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           TextFormField(
            controller: nome,
            decoration: const InputDecoration(
              hintText: 'Digite seu Nome',
              icon: Icon(Icons.account_circle_outlined),
            ),
            validator: (name) {
              if (name == null || name.isEmpty) {
                return 'Digite um nome válido';
              }
              return null;
            },
          ),

          TextFormField(
            controller: email,
            decoration: const InputDecoration(
              hintText: 'Digite seu Email',
              icon: Icon(Icons.email),
            ),
            validator: (email) {
              if (email == null || email.isEmpty) {
                return 'Digite um email válido';
              }
              return null;
            },
          ),
          TextFormField(
            obscureText: true,
            controller: senha,
            decoration: const InputDecoration(
              hintText: 'Digite uma Senha',
              icon: Icon(Icons.password),
            ),
            validator: (senha) {
              if ((senha == null || senha.isEmpty) && senha.length > 8) {
                return 'Digite uma senha válida com mais que 8 Caracteres';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {                
                if (_formKey.currentState.validate()) {
                  Usuario a = new Usuario();
                  a.name = nome.text;
                  a.email = email.text;
                  a.senha = senha.text;
                  helper.saveContact(a);                 
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageForum(
                      a:a)),
                  );
                }
              },
              child: const Text('Cadastrar Usuário'),
            ),
          ),
        ],
      ),
    )
      ),    
    );
  }

  
}