function readTextFile(fileUrl) {
    return new Promise(function (resolve, reject) {
        let request = new XMLHttpRequest;
		// Setup listener
		request.onreadystatechange = function () {
			if (request.readyState !== XMLHttpRequest.DONE) return;

			// Process the response
			if (request.status >= 200 && request.status < 300) {
				// If successful
				resolve(request);
			} else {
				// If failed
				reject({
					status: request.status,
					statusText: request.statusText
				});
			}

		};
        request.open("GET", fileUrl);
		request.send();
	});
}

function parseJson(str) {
    let obj_j;
    try {
        obj_j = JSON.parse(str);
    } catch (e) {
        if (e instanceof SyntaxError) {
            console.log(e.message);
            obj_j = null;
        } else {
          throw e;  // re-throw the error unchanged
        }
    } 
    return obj_j;
}

function readCallback(text, el) {
    let project = parseJson(text);    
    if(project !== null) {
        if("title" in project)
            el.title = project.title;
        if("preview" in project)
            el.preview = project.preview;
        if("file" in project)
            el.file = project.file;
        if("type" in project)
            el.type = project.type.toLowerCase();
    }
}

WorkerScript.onMessage = function(msg) {
    let reply = WorkerScript.sendMessage;
    if(msg.action == "loadFolder") {
        let data = msg.data;
        let plist = [];
        data.forEach(function(el) {
            let p = readTextFile(el.path + "/project.json").then(value => {
                    readCallback(value.response, el);
                });
            plist.push(p);
        });
        Promise.all(plist).then(value => {
            reply({ 'reply': msg.action, "data": data });
        });
    }
    else if(msg.action == "filter") {
        let type = msg.type;
        let data = msg.data;
        let model = msg.model;
        model.clear();
        data.forEach(function(el) {
            if(type == el.type || type == "All")
                model.append(el);
        });
        model.sync();
        reply({ 'reply': msg.action });
    }
}
