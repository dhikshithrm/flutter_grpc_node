import 'package:grpc/grpc.dart';
import 'package:grpcdemo/data/data.pbgrpc.dart';
import 'package:grpcdemo/data/data.pb.dart';

class TDClient {

  ClientChannel channel = ClientChannel("10.0.2.2",port: 4050,options: ChannelOptions(credentials: ChannelCredentials.insecure()));
  
  TodoClient client;

  TDClient(){
    client = TodoClient(channel);
  }
  createTodo(String body)async{
    final response = await client.createTodo(
      TodoItem()
      ..id = -1
      ..text = body
      );
      print("Todo item ${response.text}");
  }
  Stream<TodoItem> readTodoStream()async*{
    voidnoparam noparam = voidnoparam();
    await for (TodoItem todo in client.readTodosSTream(noparam)){
      yield todo;
     }
  }
  Future<TodoItems> readTodos()async{
    voidnoparam noparam = voidnoparam();
    TodoItems items = await client.readTodo(noparam);
    return items;
  }
  
}