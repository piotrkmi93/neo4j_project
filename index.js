let neo4j = require('neo4j');
let db = new neo4j.GraphDatabase('http://username:password@localhost:7474'),
    express = require('express'),
    bodyParser = require('body-parser');

let app = express();
app.set('view engine', 'pug');
// app.use(express.static('public'));
// app.use(bodyParser({limit: '10mb'}));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());


app.get('/', (requset, response) => {
    response.render()
});

app.listen(3000);

// db.cypher({
//     query: 'MATCH (a:Person)-[r:kocha]->(b:Person) return a,r,b;',
//     // params: {
//     //     email: 'alice@example.com',
//     // },
// }, function (err, results) {
//     console.log(err);
//     console.log(results[0]);
//     // if (err) throw err;
//     // let result = results[0];
//     // if (!result) {
//     //     console.log('No user found.');
//     // } else {
//     //     let user = result['u'];
//     //     console.log(JSON.stringify(user, null, 4));
//     // }
// });