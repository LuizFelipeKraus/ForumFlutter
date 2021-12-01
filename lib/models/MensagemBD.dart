import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Criação dos atributos do banco
final String contactTable = "BancoUsuario";
final String idColumn = "idColumn";
final String nomeColumn = "nomeColumn";
final String tituloColumn = "tituloColumn";
final String mensagemColumn = "mensagemColumn";

class MensagemHelper {
  static final MensagemHelper _instance = MensagemHelper.internal();

  factory MensagemHelper() => _instance;

  MensagemHelper.internal();

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
    final path = join(databasesPath, "mensagem.db");
    
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nomeColumn TEXT, $tituloColumn TEXT ,"
          "$mensagemColumn TEXT )");
    });
  }

  Future<Mensagem> saveContact(Mensagem contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Mensagem> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contactTable,
        columns: [idColumn, nomeColumn, tituloColumn, mensagemColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Mensagem.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact
        .delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Mensagem contact) async {
    Database dbContact = await db;
    return await dbContact.update(contactTable, contact.toMap(),
        where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Mensagem> listContact = List();
    for (Map m in listMap) {
      listContact.add(Mensagem.fromMap(m));
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

}

class Mensagem {
  int id;
  String nome;
  String titulo;
  String mensagem;

  Mensagem();

  
  Mensagem.fromMap(Map map) {
    id = map[idColumn];
    nome = map[nomeColumn];
    titulo = map[tituloColumn];
    mensagem = map[mensagemColumn];
  
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nomeColumn: nome,
      tituloColumn: titulo,
      mensagemColumn: mensagem,
    };

    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    //sobrescrita do método para facilitar a visualização dos dados
    return "Contact(id: $id, nome: $nome, titulo: $titulo, mensagem: $mensagem)";
  }
}