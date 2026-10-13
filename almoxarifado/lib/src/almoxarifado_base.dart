
import 'dart:io';
import 'item.dart';

class Almoxarifado {

  static List<Map<String, dynamic>> menu = [
    {
      'titulo': 'Listar itens do almoxarifado',
      'permissao': null,
      'metodo': listar,
    },
    {
      'titulo': 'Cadastrar item',
      'permissao': 'admin',
      'metodo': cadastrar,
    },
    {
      'titulo': 'Atualizar item',
      'permissao': 'admin',
      'metodo': atualizar,
    },
    {
      'titulo': 'Excluir item',
      'permissao': 'admin',
      'metodo': excluir,
    },
  ];

  static final List<Item> itens = [];
  static int proximoId = 1;

  // READ - Listar
  static void listar() {
    if (itens.isEmpty) {
      print('Nenhum item cadastrado.');
    } else {
      print('Itens cadastrados:');

      for (Item item in itens) {
        print('Nome: ${item.nome} | Categoria: ${item.categoria}');
      }
    }
  }

  // CREATE - Cadastrar
  static void cadastrar() {
    print('Digite o nome do item:');
    String nome = stdin.readLineSync()?.trim() ?? '';

    print('Digite a categoria do item:');
    String categoria = stdin.readLineSync()?.trim() ?? '';

    if (nome.isEmpty || categoria.isEmpty) {
      print('Nome e categoria são obrigatórios.');
      return;
    }

    Item novoItem = Item(
      id: proximoId,
      nome: nome,
      categoria: categoria,
    );

    itens.add(novoItem);
    proximoId++;

    print('Item cadastrado com sucesso!');
  }

  // READ - Buscar pelo ID
  static Item? buscarPorNome(String nomeBusca) {
    for (Item item in itens) {
      if (item.nome.toLowerCase() == nomeBusca.toLowerCase()) {
        return item;
      }
    }
    return null;
  }

  // UPDATE - Atualizar
  static void atualizar() {
    print('Digite o nome do item que deseja atualizar:');
    String nomeBusca = stdin.readLineSync()?.trim() ?? '';

    if (nomeBusca.isEmpty) {
      print('Nome inválido.');
      return;
    }

    Item? item = buscarPorNome(nomeBusca);

    if (item == null) {
      print('Item não encontrado!');
      return;
    }

    print('Digite o novo nome do item:');
    String nome = stdin.readLineSync()?.trim() ?? '';

    print('Digite a nova categoria do item:');
    String categoria = stdin.readLineSync()?.trim() ?? '';

    if (nome.isEmpty || categoria.isEmpty) {
      print('Nome e categoria são obrigatórios.');
      return;
    }

    item.nome = nome;
    item.categoria = categoria;

    print('Item atualizado com sucesso!');
  }

  // DELETE - Excluir
  static void excluir() {
    print('Digite o nome do item que deseja excluir:');
    String nomeBusca = stdin.readLineSync()?.trim() ?? '';

    if (nomeBusca.isEmpty) {
      print('Nome inválido.');
      return;
    }

    Item? item = buscarPorNome(nomeBusca);

    if (item == null) {
      print('Item não encontrado.');
      return;
    }

    itens.remove(item);

    print('Item excluído com sucesso!');
  }
}
