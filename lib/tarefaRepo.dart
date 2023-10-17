import 'package:prova/tarefa.dart';

class TarefaRepo {
  static List<Tarefa> _listTarefa = [];
  static get get_listTarefa => _listTarefa;
  set listTarefa(value) => _listTarefa = value;

  static add(Tarefa tarefa) {
    _listTarefa.add(tarefa);
  }

  static imprimir() {
    print(get_listTarefa.toString());
  }
  static remover(){
    _listTarefa.clear();
  }
}
