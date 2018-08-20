//
//  User.swift
//  App
//
//  Created by leezb101 on 2018/8/20.
//

import FluentSQLite
import Vapor

final class User: SQLiteModel {
    var id: Int? // id是SQLiteModel protocol要求的属性，但是并非手动赋值，而是在存入database时由database自主分配
    var username: String
    
    init(id: Int? = nil, username: String) {
        self.id = id
        self.username = username
    }
}

extension User: Content {} // 使User既可以序列化为json等类型，同时也能自动填充LeafView的数据模版
extension User: Migration {}
