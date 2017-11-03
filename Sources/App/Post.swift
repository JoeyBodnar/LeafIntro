//
//  Post.swift
//  App
//
//  Created by Stephen Bodnar on 11/3/17.
//

import Vapor
import FluentProvider
import HTTP
import Fluent


extension Post: ResponseRepresentable { }

final class Post: Model {
    let storage = Storage()
    
    var name: String
    
    // key names
    static let idKey = "id"
    static let nameKey = "postName"
    
    init(name: String) {
        self.name = name
    }
    
    init(row: Row) throws {
        name = try row.get(Post.nameKey)
    }
    
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Post.nameKey, name)
        try row.set(Post.idKey, id)
        return row
    }
    
}

extension Post: JSONConvertible {
    convenience init(json: JSON) throws {
        try self.init(
            name: json.get(Post.nameKey)
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Post.idKey, id)
        try json.set(Post.nameKey, name)
        return json
    }
}

extension Post: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string(Post.nameKey)
        }
    }
    
    /// Undoes what was done in `prepare`
    static func revert(_ database: Database) throws { }
}
