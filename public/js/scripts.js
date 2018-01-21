function loadData(params){
    $.post(
        window.location.href + "get_graph",
        params,
        data => {
            console.log(data);
            createGraph(data.graph);
        }
    );
}

function createGraph( { nodes, edges } ){
    let vNodes = new vis.DataSet(nodes),
        vEdges = new vis.DataSet(edges),
        container = document.getElementById('graph-space');
    let graph = new vis.Network(
        container,
        {
            nodes: vNodes,
            edges: vEdges
        },
        {
            nodes: {
                shape: 'dot',
                size: 30,
                font: {
                    size: 16
                },
                borderWidth: 2
            },
            edges: {
                font: {
                    size: 12
                },
                width: 2
            }
        }
    );

    graph.on("click", params => {
        let infoBox = document.getElementById('info-box'),
            html = "",
            nl = params.nodes.length === 1,
            el = params.edges.length === 1;
        if(nl || el){
            html += "<u><h3>About clicked element:</h3></u>";
            if (nl) html += prepareNodeInfo(nodes.find(node => node.id === params.nodes[0]));
            else    html += prepareEdgeInfo(edges.find(edge => edge.id === params.edges[0]));
        }
        infoBox.innerHTML = html;
    });
}

function prepareNodeInfo(node){
    let html = `<p><strong>${node.label}</strong></p>`;
    html += `<p>Type: ${node.type}`;
    html += `<p>ID: ${node.id}</p>`;
    if(node.properties){
        html += `Additional info:<ul>`;
        for(let n in node.properties){
            html += `<li>${n}: ${node.properties[n]}</li>`;
        }
        html += `</ul>`;
    }
    return html;
}

function prepareEdgeInfo(edge){
    let html = `<p><strong>${edge.label}</strong></p>`;
    html += `<p>ID: ${edge.id}</p>`;
    html += `<p>FromID: ${edge.from}</p>`;
    html += `<p>ToID: ${edge.to}</p>`;
    if(edge.properties && edge.properties.date){
        html += `Additional info:<ul><li>${edge.properties.date}</li></ul>`;
    }
    return html;
}

function checkboxChanges(){
    let checkboxes = {
            BelongsTo:      document.getElementById('BelongsTo').checked,
            CreatedBy:      document.getElementById('CreatedBy').checked,
            PublishedBy:    document.getElementById('PublishedBy').checked
        };

    loadData(checkboxes);
}

loadData({
    BelongsTo:  true,
    CreatedBy:      true,
    PublishedBy:    true
});