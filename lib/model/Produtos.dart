class Produtos {

//Atributos

int? id;
String nome;
String fornecedor;
double preco;

//Construtor
Produtos(this.id,this.nome,this.fornecedor, this.preco);

//Construtor com model
Produtos.deModel(Map<String,dynamic> dados):
  id = dados['id'],
  nome = dados['nome'],
  fornecedor = dados['fornecedor'],
  preco = dados['preco'];
  
//Metodos

//Converte model para map
Map<String,dynamic> toMap(){

  var dados = Map<String, dynamic>();
  dados['id'] = id;
  dados['nome'] = nome;
  dados['fornecedor'] = fornecedor;
  dados['preco'] = preco;
  return dados;
}

}