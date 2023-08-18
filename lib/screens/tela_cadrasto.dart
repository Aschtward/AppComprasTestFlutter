

import 'package:flutter/material.dart';
import 'package:minhascompras/model/Produtos.dart';
import 'package:minhascompras/util/produtosHelper.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {

  TextEditingController txtNome = TextEditingController();
  TextEditingController txtFornecedor = TextEditingController();
  TextEditingController txtPreco = TextEditingController();

  final ProdutosHelpers _repository = ProdutosHelpers();

  void salvarProduto() async{
      //Cria objeto model
      Produtos produtos = Produtos(null, txtNome.text, txtFornecedor.text, double.parse(txtPreco.text));
      _repository.save(produtos);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Cadastro de Produto"),
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
                        salvarProduto();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue
                      ),
                      child: const Text("Adicionar Produto"),                  
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