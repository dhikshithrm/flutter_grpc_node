import 'dart:io';
import 'package:grpc/grpc.dart';
import 'package:grpcdemo/data/data.pbgrpc.dart';
import 'package:grpcdemo/data/data.pb.dart';
class TDClient {
  List certs;
  Future<List> loadcerts()async{
    List cacrt = await File('lib/certs/ca.crt').readAsBytes();
    List<int> clientKey = await File('lib/certs/client.key').readAsBytes();
    List<int> clientCrt = await File('lib/certs/client.crt').readAsBytes();
    List certs = [];
    certs.addAll(cacrt);
    certs.addAll(clientKey);
    certs.addAll(clientCrt); 
    return certs;
  }
  
  
  
  TodoClient client;

  TDClient(){
    loadcerts().then((value){
      certs = value;
      print(certs);
    });
    ClientChannel channel = ClientChannel("65.0.12.145",port: 4050,options: ChannelOptions(credentials: ChannelCredentials.secure(
    certificates: certs,
    authority: "openssl")));
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