
import 'package:flutter/material.dart';
import 'package:minhascompras/screens/telaProdutos.dart';


import '../model/Produtos.dart';
import '../util/produtosHelper.dart';

// ignore: must_be_immutable
class TelaAlterarProduto extends StatefulWidget {
  Produtos produtos;
  TelaAlterarProduto({super.key, required this.produtos});
  @override
  // ignore: no_logic_in_create_state
  State<TelaAlterarProduto> createState() => _TelaAlterarProdutoState(produtos: produtos);
}

class _TelaAlterarProdutoState extends State<TelaAlterarProduto> {
  _TelaAlterarProdutoState({required this.produtos});
  Produtos produtos;
  
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtFornecedor = TextEditingController();
  TextEditingController txtPreco = TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtNome.text = produtos.nome;
    txtPreco.text = produtos.preco.toString();
    txtFornecedor.text = produtos.fornecedor;
  }

  final ProdutosHelpers _repository = ProdutosHelpers();

  void alterar() async{
      //Cria objeto model
      Produtos produtos1 = Produtos(produtos.id, txtNome.text, txtFornecedor.text, double.parse(txtPreco.text));
      _repository.update(produtos1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Alterar Produto"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: null,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    controller: txtNome,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(labelText: "Alimento"),
                    style: const TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    controller: txtFornecedor,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(labelText: "Fornecedor"),
                    style: const TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    controller: txtPreco,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(labelText: "Preço"),
                    style: const TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        alterar();
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> telaProdutos()));
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue
                      ),
                      child: const Text("Alterar Produto"),                  
                      ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}