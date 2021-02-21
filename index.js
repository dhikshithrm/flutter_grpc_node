const grpc = require("grpc");
const protoLoader = require("@grpc/proto-loader");
const packageDef = protoLoader.loadSync("todo.proto", {});
const grpcObject = grpc.loadPackageDefinition(packageDef);
const todoPackage = grpcObject.todoPackage;
const pg = require("pg");

const server = new grpc.Server();

var pool = new Pool({
    host: 'localhost',
    user: 'database-user',
    max: 20,
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 2000,
  })

server.bind("0.0.0.0:4050", grpc.ServerCredentials.createInsecure());

server.addService(todoPackage.Todo.service,
    {
        "createTodo": createTodo,
        "readTodo": readTodo,
        "readTodosSTream": readTodosSTream
    });


server.start();

const todos = []

//functions that use grpc always takes two parameters 1. call(tcp and all by client), 2. callback(seding to client)
function createTodo(req, res){
   const todoItem = {
       "id": todos.length + 1,
       "text": req.request.text
   }
   
   
   res(null, todoItem);

}

function readTodosSTream(call){

    todos.forEach(t=> call.write(t));
    call.end(); 

}

function readTodo(call, callback){
     callback(null, {"items": todos})

}



