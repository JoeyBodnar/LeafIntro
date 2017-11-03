import LeafProvider
import FluentProvider
extension Config {
    public func setup() throws {
        // allow fuzzy conversions for these types
        // (add your own types here)
        Node.fuzzy = [JSON.self, Node.self]

        setupPreparations()
        try setupProviders()
    }

    /// Configure providers
    private func setupProviders() throws {
        try addProvider(LeafProvider.Provider.self)
        try addProvider(FluentProvider.Provider.self)
    }
    
    func setupPreparations() {
        preparations.append(Post.self)
    }
}
