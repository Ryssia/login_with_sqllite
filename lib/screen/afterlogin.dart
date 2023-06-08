import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../common/routes/view_routes.dart';
import '../external/database/db_sql_lite.dart';
import '../model/tarefa_model.dart';
import '../model/user_model.dart';

class AfterLogin extends StatefulWidget {
  final UserModel userModel;
  const AfterLogin({Key? key, required this.userModel}) : super(key: key);

  @override
  _AfterLoginState createState() => _AfterLoginState();
}

class _AfterLoginState extends State<AfterLogin> {
  late final TextEditingController tarefaController = TextEditingController();
  List<String> tarefas = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<TarefaModel>> carregarTarefas() async {
    // Faça a consulta no banco de dados para buscar as tarefas
    List<TarefaModel> tarefasSalvas =
        await SqlLiteDb().getTarefas(userModel: widget.userModel);

    print("Length: ${tarefasSalvas.length}");
    return tarefasSalvas;
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as UserModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tela To Do : ${widget.userModel.userName}'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: tarefaController,
                decoration: InputDecoration(
                  labelText: 'Tarefas a fazer:',
                  hintText: 'Digite a tarefa',
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              String descricao = tarefaController.text;

              // Verifica se o campo de texto não está vazio antes de salvar a tarefa
              if (descricao.isNotEmpty) {
                TarefaModel tarefa = TarefaModel(
                  descricao: descricao,
                  userId: user.userId,
                );

                int res = await SqlLiteDb().saveTarefa(tarefa);
                print(
                    'Resultado do salvamento: $res'); // Exibe o resultado do salvamento no console

                if (res > 0) {
                  print('Tarefa salva com sucesso!');
                  tarefaController
                      .clear(); // Limpa o campo de texto após salvar a tarefa
                  await carregarTarefas(); // Atualiza a lista de tarefas exibida na tela
                  setState(() {});
                } else {
                  print('Erro ao salvar a tarefa.');
                }
              } else {
                print('Digite a descrição da tarefa antes de salvar.');
              }
            },
            child: Text('Salvar Tarefa'),
          ),
          Expanded(
            child: FutureBuilder<List<TarefaModel>>(
                future: carregarTarefas(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Erro ao consultar dados \n ${snapshot.error}");
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () async {
                              int tarefaId = snapshot.data![index].tarefaId;
                              int res = await SqlLiteDb()
                                  .deleteTarefa(tarefaId.toString());
                              setState(() {});
                            },
                          ),
                          title: Text(snapshot.data![index].descricao),
                        );
                      },
                    );
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.pushNamed(
            context,
            RoutesApp.loginUpdate,
            arguments: user,
          );
        },
        label: Text('Editar Dados do Usuário'),
        icon: Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
