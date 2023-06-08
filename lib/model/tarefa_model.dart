import 'package:login_with_sqllite/external/database/user_table_schema.dart';
import 'package:login_with_sqllite/model/user_model.dart';

import '../external/database/tarefa_table.dart';

class TarefaModel {
  late int tarefaId;
  late String descricao;
  late String userId;

  TarefaModel({
    required this.descricao,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      TarefaTableSchema.descricaoColumn: descricao,
      TarefaTableSchema.userIDColumn: userId,
    };
  }

  TarefaModel.fromMap(Map<String, dynamic> map) {
    tarefaId = map[TarefaTableSchema.tarefaIDColumn];
    descricao = map[TarefaTableSchema.descricaoColumn];
    userId = map[TarefaTableSchema.userIDColumn];
  }

  @override
  String toString() {
    return 'TarefaModel(tarefaId: $tarefaId, descricao: $descricao)';
  }
}
