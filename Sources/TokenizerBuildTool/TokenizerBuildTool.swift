import Foundation
import HTMLEntities

@main
struct TokenizerBuildTool {
    static func main() throws {
        guard CommandLine.arguments.count >= 2 else { fatalError("no arguments provided") }
        let out = CommandLine.arguments[1]

        var namedChars = namedChars
        for key in namedChars.keys {
            for i in 1..<key.count - 1 {
                let k = String(key.prefix(i))
                if !namedChars.keys.contains(k) {
                    namedChars[k] = ("\0", "\0")
                }
            }
        }

        try """
        let processedNamedChars: [String: (Unicode.Scalar, Unicode.Scalar)] = [
        \(namedChars.map { k, v in "    \(k.debugDescription): (\(v.0.debugDescription), \(v.1.debugDescription))," }.joined(separator: "\n"))
        ]
        """
        .write(toFile: out, atomically: true, encoding: .utf8)
    }
}
