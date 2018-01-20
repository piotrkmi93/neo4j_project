let neo4j = require('neo4j');
let db = new neo4j.GraphDatabase('http://username:password@localhost:7474'),
    express = require('express'),
    bodyParser = require('body-parser');

let app = express();
app.set('view engine', 'pug');
app.use(express.static('public'));
// app.use(bodyParser({limit: '10mb'}));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());


app.get('/', (requset, response) => {

    response.render('index');
});

app.get('/get_graph', (request, response) => {
    db.cypher({
        query: "MATCH (a)-[r]->(b) return a,r,b;"
    }, (err, results) => {
        if(err) throw err;
        response.send({ graph: prepareGraph(results) });
    });
});

app.listen(3000);

function prepareGraph(graph){
    let nodes = [],
        edges = [];
    for(let edge of graph){
        if( !nodes.find(node => node.id === edge.a._id) ) nodes.push(prepareNode(edge.a));
        if( !nodes.find(node => node.id === edge.b._id) ) nodes.push(prepareNode(edge.b));
        edges.push(prepareEdge(edge.r));
    }
    return { nodes: nodes, edges: edges };
}

function prepareNode(node){
    return {
        id: node._id,
        label: node.properties.name,
        type: node.labels.toString(),
        properties: getObjectWithoutName(node.properties),
        color: getNodeColor(node)
    };
}

function prepareEdge(edge){
    return {
        id: edge._id,
        from: edge._fromId,
        to: edge._toId,
        label: edge.type,
        properties: edge.properties,
        color: getEdgeColor(edge),
        arrows: "to"
    };
}

function getObjectWithoutName(object){
    let {name, ...rest} = object;
    return rest;
}

function getNodeColor(node){
    if      (~node.labels.indexOf("Game"))       return "#B4FFE3";
    else if (~node.labels.indexOf("Genre"))      return "#98FC71";
    else if (~node.labels.indexOf("Producer"))   return "#77EEFF";
    else if (~node.labels.indexOf("Publisher"))  return "#C5C7E8";
    else                                         return "#FFFFFF";
}

// function getNodeShape(node){
//     if      (~node.labels.indexOf("Game"))       return "#B4FFE3";
//     else if (~node.labels.indexOf("Genre"))      return "#98FC71";
//     else if (~node.labels.indexOf("Producer"))   return "#77EEFF";
//     else if (~node.labels.indexOf("Publisher"))  return "#C5C7E8";
//     else                                         undefined;
// }

function getEdgeColor(edge){
    if  (edge.type === "BelongsTo")     return {color:"#FFD6A2"};
    if  (edge.type === "CreatedBy")     return {color:"#E58676"};
    if  (edge.type === "PublishedBy")   return {color:"#C1BAFF"};
}