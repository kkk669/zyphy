public struct DOCTYPE {
    public var name: Optional<String>
    public var forceQuirks: Bool

    public init(
        name: __owned Optional<String> = nil,
        forceQuirks: __owned Bool = false
    ) {
        self.name = consume name
        self.forceQuirks = consume forceQuirks
    }
}

extension DOCTYPE: Equatable {}