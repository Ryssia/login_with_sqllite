import 'package:login_with_sqllite/external/database/user_table_schema.dart';

abstract class TarefaTableSchema {
  static const String nameTable = 'tarefa';
  static const String tarefaIDColumn = 'id';
  static const String descricaoColumn = 'descricao';
  static const String userIDColumn = 'id_usuario';

  static String createTarefaTableScript() => '''
    CREATE TABLE $nameTable (
      $tarefaIDColumn INTEGER PRIMARY KEY AUTOINCREMENT,
      $descricaoColumn TEXT NOT NULL,
      $userIDColumn TEXT NOT NULL,
      FOREIGN KEY ($userIDColumn) REFERENCES ${UserTableSchema.nameTable} (${UserTableSchema.userIDColumn})
    )
  ''';
}
