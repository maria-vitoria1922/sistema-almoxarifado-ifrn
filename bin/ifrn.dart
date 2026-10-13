import 'dart:io';

import 'package:almoxarifado/almoxarifado.dart';

const String version = '0.0.1';

void main(List<String> arguments) {
  // Usuários fictícios para demonstração até a integração da classe Usuario
  // do Grupo 1. Em uma aplicação real, o perfil viria do login autenticado.
  final usuario1 = {
    'nome': 'Fulano',
    'perfil': 'aluno',
    'permissoes': <String>[],
  };
  final usuario2 = {
    'nome': 'Beltrano',
    'perfil': 'tecnico_administrativo',
    'permissoes': <String>['admin'],
  };

  // Usuário ativo para demonstração. Troque para usuario1 para testar o bloqueio.
  final usuario = usuario2;

  final opcoes = <Map<String, dynamic>>[
    ...Almoxarifado.menu,
    ...Retiradas.menu(
      nomeUsuario: usuario['nome'] as String,
      perfilUsuario: usuario['perfil'] as String,
    ),
  ];

  String input;
  do {
    print('============= IFRN Almoxarifado =============\n');
    print('Usuário: ${usuario['nome']} | Perfil: ${usuario['perfil']}');
    print('Menu:');
    for (var i = 0; i < opcoes.length; i++) {
      print('$i - ${opcoes[i]['titulo']}');
    }

    stdout.write('\nDigite uma opção (ou "sair"): ');
    input = stdin.readLineSync()?.trim() ?? '';

    if (input == 'sair') {
      print('Obrigado por usar o IFRN Almoxarifado. Até a próxima!');
      break;
    }

    final escolha = int.tryParse(input);
    if (escolha == null || escolha < 0 || escolha >= opcoes.length) {
      print('Opção inválida.');
    } else {
      final opcao = opcoes[escolha];
      final perfisPermitidos = opcao['perfisPermitidos'] as List<String>?;
      final permissaoLegada = opcao['permissao'] as String?;

      // O módulo de retiradas usa perfil funcional; o CRUD existente mantém
      // a permissão admin enquanto a classe real de usuário não é integrada.
      if (perfisPermitidos != null &&
          !perfisPermitidos.contains(usuario['perfil'])) {
        print('Acesso negado. Seu perfil não pode realizar essa operação.');
      } else if (permissaoLegada != null &&
          !(usuario['permissoes'] as List<String>).contains(permissaoLegada)) {
        print('Acesso negado. Você não tem permissão para fazer isso.');
      } else {
        final metodo = opcao['metodo'] as Function;
        metodo();
      }
    }

    stdout.write('\nAperte ENTER para continuar...');
    stdin.readLineSync();
  } while (true);
}
