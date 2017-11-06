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
extension Post: NodeRepresentable { }

final class Post: Model {
    let storage = Storage()
    
    var name: String
    var isPublished: Bool
    // key names
    static let idKey = "id"
    static let nameKey = "name"
    static let isPublishedKey = "published"
    
    init(name: String, isPublished: Bool) {
        self.name = name
        self.isPublished = isPublished
    }
    
    init(row: Row) throws {
        name = try row.get(Post.nameKey)
        isPublished = try row.get(Post.isPublishedKey)
    }
    
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Post.nameKey, name)
        try row.set(Post.idKey, id)
        try row.set(Post.isPublishedKey, isPublished)
        return row
    }
    
    
    
}

extension Post: JSONConvertible {
    convenience init(json: JSON) throws {
        try self.init(
            name: json.get(Post.nameKey),
            isPublished: json.get(Post.isPublishedKey)
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Post.idKey, id)
        try json.set(Post.nameKey, name)
        try json.set(Post.isPublishedKey, isPublished)
        return json
    }
}

extension Post: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string(Post.nameKey)
            builder.bool(Post.isPublishedKey)
        }
    }
    
    /// Undoes what was done in `prepare`
    static func revert(_ database: Database) throws { }
}
