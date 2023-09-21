# Zyphy

Zyphy is (or will be) a fast web browser engine written in Swift, and is partially inspired by Servo's [html5ever](https://github.com/servo/html5ever).

> [!IMPORTANT]
> This package is under development.

## Prerequisites

- Swift nightly toolchain

On Linux, you can easily install the toolchain using [swiftly](https://swift-server.github.io/swiftly/).

```shell
curl -L https://swift-server.github.io/swiftly/swiftly-install.sh | bash
swiftly install main-snapshot
```

## Building

```shell
swift build
```

## Testing

```shell
swift test
```

## Benchmarking

You must install jemalloc beforehand. (`pacman -S jemalloc`, `apt install libjemalloc-dev`, or something)

```shell
swift package --package-path Benchmarks benchmark
```

For more details, please see https://github.com/ordo-one/package-benchmark.
