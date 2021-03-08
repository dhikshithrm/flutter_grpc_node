import 'package:flutter/material.dart';
import 'services/client.dart';
import 'data/data.pb.dart';


class MessagePage extends StatefulWidget {
  final TDClient chatService = TDClient();
 
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController controller;
  List messages;


  @override
  void initState() { 
    super.initState();
    messages = [];
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Page"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: controller,
              ),
            ),
            Flexible(
              flex: 2,
              child: MaterialButton(
                child: Text("Send"),
                color: Colors.yellow,
                onPressed: (){
                widget.chatService.createTodo(controller.text);
                controller.clear();
                setState(() {});
              }),
            ),
            Flexible(
              flex: 15,
              child: FutureBuilder<TodoItems>(
              future: widget.chatService.readTodos(),
              builder: (context,snapshot){
                if(snapshot.connectionState!=ConnectionState.done){
                  return Center(child: CircularProgressIndicator(),);
                }
                return ListView(
                  children: snapshot.data.items.map((e) => ListTile(title: Text(e.text),leading: Text("${e.id}"),)).toList()
                  );
              },
            ))
          ],
        ),
      ),
    );
  }
}