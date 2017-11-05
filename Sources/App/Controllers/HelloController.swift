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
        let post1 = Post(name: "testing Post 1")
        let post2 = Post(name: "testing Post 2")
        let post3 = Post(name: "testing Post 3")
        let post4 = Post(name: "testing Post 4")
        
        let node1 = try Node(node: post1.makeJSON())
        let node2 = try Node(node: post2.makeJSON())
        let node3 = try Node(node: post3.makeJSON())
        let node4 = try Node(node: post4.makeJSON())
        
        let nodeArray = [node1, node2, node3, node4]
        return try view.make("hello", ["posts": nodeArray], for: req)
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
