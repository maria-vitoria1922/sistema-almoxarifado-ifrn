
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
        print('ID: ${item.id} | Nome: ${item.nome} | Categoria: ${item.categoria}');
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
    print('ID gerado: ${novoItem.id}');
  }


  // READ - Buscar pelo ID
  static Item? buscarPorId(int id) {
    for (Item item in itens) {
      if (item.id == id) {
        return item;
      }
    }

    return null;
  }


  // UPDATE - Atualizar
  static void atualizar() {
    print('Digite o ID do item que deseja atualizar:');
    int? id = int.tryParse(stdin.readLineSync() ?? '');

    if (id == null) {
      print('ID inválido.');
      return;
    }

    Item? item = buscarPorId(id);

    if (item == null) {
      print('Item não encontrado.');
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
    print('Digite o ID do item que deseja excluir:');
    int? id = int.tryParse(stdin.readLineSync() ?? '');

    if (id == null) {
      print('ID inválido.');
      return;
    }

    Item? item = buscarPorId(id);

    if (item == null) {
      print('Item não encontrado.');
      return;
    }

    itens.remove(item);

    print('Item excluído com sucesso!');
  }
}
