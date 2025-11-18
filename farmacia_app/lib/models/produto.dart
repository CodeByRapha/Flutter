class Produto {
  String id;
  String nome;
  double preco;
  bool receitaObrigatoria;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    this.receitaObrigatoria = false,
  });
}
