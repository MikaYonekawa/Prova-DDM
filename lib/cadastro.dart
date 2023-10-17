import 'package:flutter/material.dart';
import 'package:prova/tarefa.dart';
import 'package:prova/tarefaRepo.dart';

class MyCadastro extends StatefulWidget {
  const MyCadastro({super.key});

  @override
  State<MyCadastro> createState() => _MyCadastroState();
}

class _MyCadastroState extends State<MyCadastro> {
  final campoNome = TextEditingController();
  final FocusNode focoNome = FocusNode();
  List<Tarefa> list = TarefaRepo.get_listTarefa;
  String busca = "";
  late List<Tarefa> listBusca;
  void atualizaLista(String nome) {
    listBusca = List.from(list);
    setState(() {}); //fazer validação
  }

  void initState() {
    // TODO: implement initState
    listBusca = List.from(list);
    super.initState();
  }

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Form(
                key: this._formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              controller: campoNome,
                              keyboardType: TextInputType.text,
                              focusNode: focoNome,
                              decoration: InputDecoration(
                                labelText: 'Tarefa',
                                labelStyle: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 54, 54, 54)), //
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Campo obrigatório";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                            width: 130,
                            child: ElevatedButton.icon(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    String nome = campoNome.text;
                                    Tarefa t = Tarefa(nome);
                                    TarefaRepo.add(t);
                                    atualizaLista(nome);
                                    TarefaRepo.imprimir();
                                    setState(() {});
                                  }
                                },
                                icon: Icon(Icons.pest_control_rodent),
                                label: Text('Cadastrar')),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.pest_control_rodent_outlined),
                      ),
                      title: Text(listBusca[index].nome),
                      subtitle: Text(''),
                      trailing: Icon(Icons.access_alarms_rounded),
                    );
                  },
                  separatorBuilder: (_, __) => Divider(
                        thickness: 2,
                      ),
                  itemCount: listBusca.length),
            ),
            ElevatedButton(
                onPressed: () {
                  listBusca.clear();
                  TarefaRepo.remover();
                  _formKey.currentState!.reset();
                  campoNome.clear();
                  listBusca = [];

                  setState(() {

                  });
                },
                child: Text('Limpar'))
          ],
        ),
      ),
    );
  }
}
