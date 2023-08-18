import 'package:flutter/material.dart';
import 'package:minhascompras/screens/telaAlterarProduto.dart';
import 'package:minhascompras/util/produtosHelper.dart';

import '../model/Produtos.dart';

class telaProdutos extends StatefulWidget {
  const telaProdutos({super.key});

  @override
  State<telaProdutos> createState() => _telaProdutosState();
}

class _telaProdutosState extends State<telaProdutos> {
  ProdutosHelpers db = ProdutosHelpers();
  List<Produtos> produtosRecuperados = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    recuperarProdutos();
  }

  //Metodos de interação com banco de dados
  void recuperarProdutos() async {
    List<Produtos> esperaLista = await db.list();
    setState(() {
      produtosRecuperados = esperaLista;
    });
  }

  void exlcuirProdutos(Produtos produtos) async {
    await db.delete(produtos.id!);
    recuperarProdutos();
  }

  //Alert dialog de confimação de exclusão de produto
  void confirmarRemocao(Produtos produtos) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Excluir produto"),
            content:
                Text("Confirme que deseja excluir o produto: ${produtos.nome}"),
            actions: [
              TextButton(
                onPressed: () {
                  exlcuirProdutos(produtos);
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red, foregroundColor: Colors.white),
                child: const Text("Confirmar"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
                child: const Text("Cancelar"),
              )
            ],
          );
        });
  }

  Widget verificaLista(List<Produtos> produtosRecuperados) {
    if (produtosRecuperados.isEmpty) {
      return const Center(
        child:  Text("Nada por aqui ainda...", style: TextStyle(fontSize: 20),),
      );
    }
    return ListView.builder(
      itemCount: produtosRecuperados.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(
              produtosRecuperados[index].nome,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              produtosRecuperados[index].preco.toString(),
              style: const TextStyle(color: Colors.red),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    confirmarRemocao(produtosRecuperados[index]);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TelaAlterarProduto(produtos: produtosRecuperados[index])));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lista de Produto"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: verificaLista(produtosRecuperados));
  }
}
