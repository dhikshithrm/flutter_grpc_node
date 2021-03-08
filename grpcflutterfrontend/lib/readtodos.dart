import 'services/client.dart';
TDClient tdClient = TDClient();

void main(){
  tdClient.readTodos().then((value) => print(value));
}