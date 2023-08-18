// ignore_for_file: file_names

import 'dart:io';

import 'package:minhascompras/model/Produtos.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ProdutosHelpers{

static Database? _database;
static final ProdutosHelpers instance = ProdutosHelpers._createInstance();

ProdutosHelpers._createInstance();

ProdutosHelpers(){

}

//Difinindo estrutura da tabela

String nomeTabela = 'tb_produtos';
String colunaId = 'id';
String colunaNome = 'nome';
String colunaFornecedor = 'fornecedor';
String colunaPreco = 'preco';

//Criando banco de dados
void _criarBanco(Database db, int version) async {
  String sql = """CREATE TABLE $nomeTabela (
    $colunaId INTEGER PRIMARY KEY AUTOINCREMENT,
    $colunaNome Text,
    $colunaFornecedor Text,
    $colunaPreco Float
  )""";

  await db.execute(sql);
}

Future<Database> inicializaBanco() async{
  //Busca caminho para salvar o bd
  Directory directory = await getApplicationDocumentsDirectory();
  String caminho = '${directory.path}bdprodutos.bd';
  var bancodedados = await openDatabase(caminho, version: 1, onCreate: _criarBanco);
  return bancodedados;
}

//Verifica se o banco foi inicializado
 Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await inicializaBanco();
    return _database!;
  }  

//Inserir produtos
Future<int> save(Produtos produtos) async{
  Database db = await database;
  var resposta = await db.insert(nomeTabela, produtos.toMap());
  return resposta;
}

//Listar produtos
Future<List<Produtos>> list() async {
  Database db = await database;
  String sql = """SELECT * FROM $nomeTabela""";
  List<Map<String, dynamic>> list = await db.rawQuery(sql);
  List<Produtos> produtos = List<Produtos>.empty(growable: true);
  for (var element in list) {
      produtos.add(Produtos(element['id'], element['nome'], element['fornecedor'], element['preco']));
  }
  return produtos;
}
//Deletar produtos
Future<int> delete(int id) async {
  Database db = await database;
  return db.delete(nomeTabela, where : 'id = ?', whereArgs: [id]);
}
//Alterar produtos
Future<int> update(Produtos produtos) async {
  Database db = await database;
  return db.update(nomeTabela, produtos.toMap(), where: 'id = ?', whereArgs: [produtos.id]);
}

}