const grpc = require("grpc");
const protoLoader = require("@grpc/proto-loader");
const packageDef = protoLoader.loadSync("todo.proto", {});
const grpcObject = grpc.loadPackageDefinition(packageDef);
const todoPackage = grpcObject.todoPackage;
const pg = require("pg");

const server = new grpc.Server();

var pool = new pg.Pool({
    host: "localhost",
    user: "postgres",
    database: "postgres",
    password: "password",
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
var client;
var length;
(async function(){
    client = await pool.connect();
    length = await (await client.query("select id from todo order by id desc limit 1")).rows[0]
    if(JSON.stringify(length)!=null){
        length = length.id
    }else{
        length = 0;
    }
    
    length = parseInt(length)
   
})()

function incrementId(){
    length = length+1;
}
//functions that use grpc always takes two parameters 1. call(tcp and all by client), 2. callback(seding to client)
function createTodo(req, res){
   incrementId()
   const todoItem = {
       "id": length,
       "text": req.request.text
   }
   client.query("insert into todo(id,content) values ($1,$2)",[todoItem.id,todoItem.text])
   .then(()=>console.log("insert successful"))
   .catch(err => console.log(err))
    res(null, todoItem);

}

function readTodosSTream(call){
    client.query("select * from todo")
    .then(result => result.rows.forEach(t => call.write({"id": t.id, "text": t.content})))
    .catch(err => console.log(err))
    call.end(); 

}

function readTodo(call, callback){
    client.query("select * from todo").
    then(result => callback(null, {"items": result.rows.map((i)=> i = {"id":i.id,"text":i.content})}))
    .catch((err)=>{ 
        console.log(err)
        callback(null, `error occured: ${err}`) 
      })
    
}



