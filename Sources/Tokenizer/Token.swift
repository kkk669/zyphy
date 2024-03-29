public enum Token: Equatable, Sendable {
    case char(Character)
    case tag(Tag)
    case comment(String)
    case doctype(DOCTYPE)
    case eof
    case error(ParseError)
}

extension Token: ExpressibleByExtendedGraphemeClusterLiteral {
    public init(extendedGraphemeClusterLiteral value: Character) {
        self = .char(value)
    }
}
