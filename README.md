# Sistema de Almoxarifado IFRN

Aplicação de linha de comando em Dart para gerenciar itens e registrar retiradas.

## Módulos presentes

- **Almoxarifado / Itens:** listar, cadastrar, atualizar e excluir itens.
- **Retiradas:** registrar e listar retiradas, validar quantidades e atualizar o estoque.
- **Permissões de retirada:** permite apenas os perfis `professor` e `tecnico_administrativo`.

## Executar

Na raiz do projeto:

```bash
dart pub get
dart run bin/ifrn.dart
```

## Testar

```bash
dart test
dart analyze
```

## Observação sobre autenticação

O arquivo `bin/ifrn.dart` usa usuários fictícios apenas para demonstrar a integração. O perfil deve vir da classe e do processo de autenticação do Grupo 1 quando forem integrados. A validação de retirada é feita também na camada de regras de negócio, e não somente no menu.
