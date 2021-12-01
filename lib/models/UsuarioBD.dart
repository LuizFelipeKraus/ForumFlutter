import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Criação dos atributos do banco
final String contactTable = "bancoUsuario";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String senhaColumn = "senhaColumn";

class UsuarioHelper {
  static final UsuarioHelper _instance = UsuarioHelper.internal();

  factory UsuarioHelper() => _instance;

  UsuarioHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "user.db");
    
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT UNIQUE,"
          "$senhaColumn TEXT )");
    });
  }

  Future<Usuario> saveContact(Usuario contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Usuario> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contactTable,
        columns: [idColumn, nameColumn, emailColumn, senhaColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Usuario.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact
        .delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Usuario contact) async {
    Database dbContact = await db;
    return await dbContact.update(contactTable, contact.toMap(),
        where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Usuario> listContact = List();
    for (Map m in listMap) {
      listContact.add(Usuario.fromMap(m));
    }
    return listContact;
  }

  Future<int> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }

     Future<Usuario> returnLogin(String login, String senha) async {
     Database dbContact = await db;
     
     List<Map> res = await dbContact.query(contactTable,
        columns:[idColumn, nameColumn, emailColumn, senhaColumn],
        where:"emailColumn = ? and senhaColumn = ?",
        whereArgs:[login, senha]);
      
      
      if (res.length > 0) {
        return Usuario.fromMap(res.first);       
      }else{
        return null;
      } 
    }
  

}

class Usuario {
  int id;
  String name;
  String email;
  String senha;

  Usuario();

  //Construtor - quando formos armazenar em nosso bd, vamos armazenar em
  //um formato de mapa e para recuperar os dados, precisamos transformar
  //esse map de volta em nosso contato.
  Usuario.fromMap(Map map) {
    // nessa função eu pego um map e passo para o meu contato
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    senha = map[senhaColumn];
  
  }

  Map toMap() {
    // aqui eu pego contato e transformo em um map
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      senhaColumn: senha,
    };

    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    //sobrescrita do método para facilitar a visualização dos dados
    return "Contact(id: $id, name: $name, email: $email, senha: $senha)";
  }
}