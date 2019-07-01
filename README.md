# Mix Elvis

Run [Elvis][elvis] linter for projects that are using Mix.

## Installation

The package can be installed by adding `mix_elvis` to your list of dependencies
in `mix.exs`:

```elixir
def deps do
  [
    {:mix_elvis, "~> 0.1.0"}
  ]
end
```

## Usage

Install and run `mix elvis`. You can configure Elvis via:

- `elvis.config` file (Erlang `file:consult/1` format)
- `:elvis` entry in project configuration (remember to use charlists instead of
  binaries)
- application configuration (remember to use charlists as well)

## License

See [LICENSE](LICENSE).

[elvis]: https://github.com/inaka/elvis_core
