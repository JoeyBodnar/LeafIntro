import Vapor
import HTTP

/// Here we have a controller that helps facilitate
/// creating typical REST patterns
final class HelloController: ResourceRepresentable {
    
    let view: ViewRenderer
    init(_ view: ViewRenderer) {
        self.view = view
    }

    /// GET /hello
    func index(_ req: Request) throws -> ResponseRepresentable {
        let post1 = Post(name: "testing Post 1", isPublished: true)
        try post1.save()
        let post2 = Post(name: "testing Post 2", isPublished: false)
        /* let post3 = Post(name: "testing Post 3", isPublished: true)
        let post4 = Post(name: "testing Post 4", isPublished: false)
        
        let node1 = try Node(node: post1.makeJSON())
        let node2 = try Node(node: post2.makeJSON())
        let node3 = try Node(node: post3.makeJSON())
        let node4 = try Node(node: post4.makeJSON())
        print("node1 is \(node1)")
        let nodeArray = [node1, node2, node3, node4] */
        let firstPost = try Post.makeQuery().first()!
        let node1 = try Node(node: firstPost.makeJSON())
        let node2 = try Node(node: post2.makeJSON())
        print("the first node is \(node1)")
        print("the second node is \(node2)")
        let json = try post2.makeJSON()
        print("the json is \(json)")
        return try view.make("hello", ["posts": node1], for: req)
    }

    /// GET /hello/:string
    func show(_ req: Request, _ string: String) throws -> ResponseRepresentable {
        return try view.make("hello", [
            "name": string
        ], for: req)
    }

    /// When making a controller, it is pretty flexible in that it
    /// only expects closures, this is useful for advanced scenarios, but
    /// most of the time, it should look almost identical to this
    /// implementation
    func makeResource() -> Resource<String> {
        return Resource(
            index: index,
            show: show
        )
    }
}
