//
//  UserController.swift
//  App
//
//  Created by leezb101 on 2018/8/21.
//

import Vapor

final class UserController {
    
    
    func list(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    #if false // 这里的方法是使用Leaf时对应渲染视图用的
    func list(_ req: Request) throws -> Future<View> {
        return User.query(on: req).all().flatMap({ (users) in
            let data = ["userlist": users]
            return try req.view().render("crud", data)
        })
    }
    #endif
    
    func create(_ req: Request) throws -> Future<User> {
        return try req.content.decode(User.self).flatMap{ user in
            return user.save(on: req)
        }
    }
    
    func update(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self).flatMap { user in
            return try req.content.decode(UserForm.self).flatMap { newUser in
                user.username = newUser.username
                return user.save(on: req)
            }
        }
    }
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(User.self).flatMap { user in
            return user.delete(on: req)
        }.transform(to: HTTPStatus.ok)
    }
    
}

struct UserForm: Content {
    var username: String
}
