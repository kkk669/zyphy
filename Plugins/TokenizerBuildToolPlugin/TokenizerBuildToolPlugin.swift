import Foundation
import PackagePlugin

@main
struct TokenizerBuildToolPlugin {}

extension TokenizerBuildToolPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        let out = context.pluginWorkDirectory.appending("generated.swift")
        return [
            .buildCommand(
                displayName: "TokenizerBuildToolPlugin",
                executable: try context.tool(named: "TokenizerBuildTool").path,
                arguments: [out],
                outputFiles: [out]
            )
        ]
    }
}
