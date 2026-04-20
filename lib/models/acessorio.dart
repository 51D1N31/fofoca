class Acessorio {
  final String nome;
  final String categoria;

  Acessorio({required this.nome, required this.categoria});
}

final List<Acessorio> listaAcessorios = [
  Acessorio(nome: 'Borboleta', categoria: 'cabeca'),
  Acessorio(nome: 'Laço', categoria: 'cabeca'),
];
