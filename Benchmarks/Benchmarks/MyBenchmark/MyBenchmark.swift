private import Benchmark
private import DequeModule
private import Foundation
private import Tokenizer

private struct TestSink {}

extension TestSink: TokenSink {
    func process(_ token: consuming Token) {
        blackHole(token)
    }
}

private func runBench(_ name: String, configuration conf: Benchmark.Configuration) {
    // swift-format-ignore: NeverUseForceTry, NeverForceUnwrap
    let html = try! String(contentsOf: Bundle.module.url(forResource: name, withExtension: "html")!)
    let input = Deque(consume html)
    Benchmark(name, configuration: conf) { benchmark in
        for _ in benchmark.scaledIterations {
            var tokenizer = Tokenizer(sink: TestSink())
            var input = input
            tokenizer.tokenize(&input)
        }
    }
}

@MainActor
let benchmarks = {
    let conf = Benchmark.Configuration(
        metrics: [.wallClock],
        warmupIterations: 10,
        scalingFactor: .kilo,
        maxDuration: .seconds(60),
        maxIterations: 100
    )

    runBench("lipsum", configuration: conf)
    runBench("lipsum-zh", configuration: conf)
    runBench("medium-fragment", configuration: conf)
    runBench("small-fragment", configuration: conf)
    runBench("tiny-fragment", configuration: conf)
    runBench("strong", configuration: conf)
}
