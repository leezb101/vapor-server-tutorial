import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    #if false
    router.get("users") { (req) -> Future<View> in
        return User.query(on: req).all().flatMap({ (users) in
            let data = ["userlist": users]
            return try req.view().render("userview", data)
        })
    }
    #endif
    
    // 以上代码中的closure实现迁移至controllers，改写为
    let userController = UserController()
    router.get("users", use: userController.list)
    router.post("users", use: userController.create)
    router.post("users", User.parameter, "update", use: userController.update)
    router.post("users", User.parameter, "delete", use: userController.delete)
    
    #if false
    router.post("users") { (req) -> Future<Response> in
        return try req.content.decode(User.self).flatMap({ (user) in
            return user.save(on: req).map({ (_) in
                return req.redirect(to: "users")
            })
        })
    }
    #endif
    
    
    #if false
//  下面的部分是初始学习router和leaf使用的
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
    #endif
}

struct Person: Content {
    var name: String
    var age: Int
}
