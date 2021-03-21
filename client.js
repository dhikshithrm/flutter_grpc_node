const grpc = require("grpc");
const protoLoader = require("@grpc/proto-loader");
const packageDef = protoLoader.loadSync("todo.proto", {});
const grpcObject = grpc.loadPackageDefinition(packageDef);
const todoPackage = grpcObject.todoPackage;
const fs = require('fs');


const credentials = grpc.credentials.createSsl(
    fs.readFileSync('./grpcflutterfrontend/lib/certs/ca.crt'),
    fs.readFileSync('./grpcflutterfrontend/lib/certs/client.key'),
    fs.readFileSync('./grpcflutterfrontend/lib/certs/client.crt')
);
var options = {
    'grpc.ssl_target_name_override' : 'piedpiers.technology',
    'grpc.default_authority': 'piedpiers.technology'
  };
const text = process.argv[2]
const client = new todoPackage.Todo("65.0.12.145:4050", credentials,options);

if(text!=undefined){
    client.createTodo({
    "id": -1,
    "text": text
},(err,response)=>{
    console.log("Recieved from server "+ JSON.stringify(response));
})}

client.readTodo({},(err,response)=>{
    console.log("recieved from server "+ JSON.stringify(response));   
    
      
})
const call = client.readTodosSTream();

call.on("data", item=>{
   console.log("received item from server "+ JSON.stringify(item))
})
call.on("end",e=> console.log("server done!"));
