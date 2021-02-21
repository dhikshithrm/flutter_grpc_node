const grpc = require("grpc");
const protoLoader = require("@grpc/proto-loader");
const packageDef = protoLoader.loadSync("todo.proto", {});
const grpcObject = grpc.loadPackageDefinition(packageDef);
const todoPackage = grpcObject.todoPackage;

const text = process.argv[2]
const client = new todoPackage.Todo("localhost:4050", grpc.credentials.createInsecure());


client.createTodo({
    "id": -1,
    "text": text
},(err,response)=>{
    console.log("Recieved from server "+ JSON.stringify(response));
})
client.readTodo({},(err,response)=>{
    console.log("recieved from server "+ JSON.stringify(response));   
    response.items.forEach(i => console.log(i.text));
      
    
})
const call = client.readTodosSTream();

call.on("data", item=>{
   console.log("received item from server "+ JSON.stringify(item))
})
call.on("end",e=> console.log("server done!"));
