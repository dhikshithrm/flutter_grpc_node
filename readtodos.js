const {Client} = require('pg');
const client = new Client({
	user: "postgres",
	password: "password",
	host: "localhost",
	database: "postgres",
	port: 5432

});

client.connect()
.then(() => console.log("Connected Successfully"))
.then(() => client.query("select * from todo"))
.then(result => console.log(result.rows))
.catch(e => console.log(e))
.finally(() => client.end())


