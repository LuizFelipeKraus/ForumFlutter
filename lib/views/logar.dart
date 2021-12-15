import 'package:flutter/material.dart';
import 'package:forumapp/models/UsuarioBD.dart';
import 'package:forumapp/views/cadastrar.dart';
import 'package:forumapp/views/page_forum.dart';

class Login extends StatefulWidget {
  const Login({ Key key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double displayHeight() => MediaQuery.of(context).size.height;
  
  double displayWidth() => MediaQuery.of(context).size.width;

  UsuarioHelper helper = UsuarioHelper();
  bool a = true;
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text("LOGAR"),
        centerTitle: true ,
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
            controller: email,
            decoration: const InputDecoration(
              hintText: 'Digite o Email',
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
              hintText: 'Digite a Senha',
              icon: Icon(Icons.password),
            ),
            validator: (senha) {
              if ((senha == null || senha.isEmpty) && senha.length > 8) {
                return 'Digite uma mensagem válida com mais que 8 Caracteres';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {                
                if (_formKey.currentState.validate()) {
                   await helper.returnLogin(email.text, senha.text).then((val) async {
                           if(val == null){
                             _showDialog();
                           }else {   
                             print(val);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PageForum(a : val)),
                              );
                          }
                  }); 
                }
              },
              child: const Text('Logar no sistema'),
            ),
          ),
        ],
      ),
    )
      ),
        
    );
  }
  
void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Email ou senha não corresponde"),
          content: new Text("Veja se você digitou a senha ou email certo.\n" + "Caso contrário crie uma conta."),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("Cadastrar"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cadastro()),
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