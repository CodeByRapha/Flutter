class Produto {
  final String id;
  final String nome;
  final double preco;
  final bool receitaObrigatoria;
  String? receitaImagem;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    this.receitaObrigatoria = false,
    this.receitaImagem,
  });
}
