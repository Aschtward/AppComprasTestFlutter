import 'package:flutter/material.dart';
import 'package:minhascompras/screens/telaProdutos.dart';
import 'package:minhascompras/screens/tela_cadrasto.dart';

Widget menu_drawer(BuildContext context){
  return Drawer(
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(40),
          width: double.infinity,
          height: 230,
          color: Colors.blue,
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top:10),
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage('https://www.petz.com.br/blog/wp-content/uploads/2021/11/enxoval-para-gato-Copia.jpg'),
                    fit: BoxFit.cover
                    )
                  ),
                ),
                const SizedBox(height: 10,),
                const Text("Minha Lista de Compras", style:TextStyle(fontSize: 18, color: Colors.white)),
                const Text("Desenvolvidos por Aschward", style:TextStyle(fontSize: 12, color: Colors.white)),
              ],
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.add, color: Colors.blue),
          title: const Text("Novo Produto", style: TextStyle(fontSize: 16),),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaCadastro()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.food_bank, color: Colors.blue),
          title: const Text("Meus Produtos", style: TextStyle(fontSize: 16),),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const telaProdutos()));
          },
        )
      ],
    ),
  );
}