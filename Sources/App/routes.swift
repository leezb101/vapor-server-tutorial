import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("name") { (request) in
        return "Liyiqun"
    }
    
    router.get("age") { (req) in
        return "\(27)"
    }
    
    router.get("json") { (req) in
        return Person(name: "liyiqun", age: 27)
    }
    
    router.get("view") { (req) -> Future<View> in
        return try req.view().render("welcome")
    }
    
    router.get("bonus") { (req) -> Future<View> in
        let data = ["name": "Liyiqun", "age": "27"]
        return try req.view().render("whoami", data)
    }
    
    router.get("bonus-s") { (req) -> Future<View> in
        let developer = Person(name: "Liyiqun", age: 27)
        return try req.view().render("whoamiobj", developer)
    }
}

struct Person: Content {
    var name: String
    var age: Int
}
