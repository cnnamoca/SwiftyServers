import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "🤡")
            return json
        }
        
        // Respond to curl localhost:8080/upcase?words="yourword"
        get("upcase") { req in
            guard let value = req.data["words"]?.string else {
                return "Error retrieving parameters\n"
            }
            return "\(value.uppercased())\n"
        }
        
        post("user") {request in
            guard let name = request.json?["name"]?.string else{
                fatalError("Required parameter name not found")
            }
            
            return try JSON(node: name)
        }

        let store = Store()
        
        post("store") {req in
            guard let key = req.data["key"]?.string else {
                return "Error retrieving parameters\n"
            }
            guard let value = req.data["value"]?.string else {
                return "Error retrieving parameters\n"
            }
            
            store.set(key: key, value: value)
            
            return "\(key) : \(value) \n"
        }
        
        get("lookup", String.parameter) { req in
            guard let key = try? req.parameters.next(String.self).string else {
                return "Error retrieving parameters\n"
            }
            let value = store.get(key: key)
            return "\(value)\n"
        }
        
        get("retrieve"){ req in
            return ("\(store.allItems())")   
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }
        
        try resource("posts", PostController.self)
    }
}
