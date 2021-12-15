import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forumapp/models/MensagemBD.dart';
import 'package:forumapp/models/UsuarioBD.dart';
import 'package:forumapp/views/page_forum.dart';


class MensagemAplicacao extends StatefulWidget {
  Usuario a;
  MensagemAplicacao({this.a});
  @override
  _MensagemAplicacaoState createState() => _MensagemAplicacaoState();
}

class _MensagemAplicacaoState extends State<MensagemAplicacao> {
  TextEditingController titulo = TextEditingController();
  TextEditingController mensagem = TextEditingController();
  String nome = "";
  MensagemHelper helper = MensagemHelper();
  bool _userEdited = false;
  Usuario _editedContact;
  
  final _formKey = GlobalKey<FormState>();
   @override
  void initState() {
    super.initState();
    if (widget.a == null) {
      _editedContact = Usuario();
    } else {
      _editedContact = Usuario.fromMap(widget.a.toMap());

      nome = _editedContact.name;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Text('CADASTRAR MENSAGEM'),
        centerTitle: true ,
      ),
      backgroundColor: Colors.blue[100],
      body:   SingleChildScrollView(
          child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
             maxLines : null,
            controller: titulo,
            decoration: const InputDecoration(
              hintText: 'Digite o Titulo',
              icon: Icon(Icons.title),
            ),
            validator: (titulo) {
              if (titulo == null || titulo.isEmpty) {
                return 'Digite um título válido';
              }
              return null;
            },
          ),
          TextFormField(
            maxLines : null,
            controller: mensagem,
            decoration: const InputDecoration(
              hintText: 'Digite a Mensagem',
              icon: Icon(Icons.assignment),
            ),
            validator: (mensagem) {
              if (mensagem == null || mensagem.isEmpty) {
                return 'Digite uma mensagem válida';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {                
                if (_formKey.currentState.validate()) {
                  Mensagem Mmensagem = new Mensagem();
                  Mmensagem.titulo = titulo.text;
                  Mmensagem.mensagem = mensagem.text;
                  Mmensagem.nome = nome;
                  
                  helper.saveContact(Mmensagem);
                     
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageForum(a:_editedContact)),
                  );
                }
              },
              child: const Text('Enviar Mensagem'),
            ),
          ),
        ],
      ),
    )
        ),      
    );
  }
}