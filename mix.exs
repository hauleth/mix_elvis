defmodule MixElvis.MixProject do
  use Mix.Project

  def project do
    [
      app: :mix_elvis,
      version: "0.1.0",
      elixir: "~> 1.6",
      deps: deps()
    ]
  end

  defp deps do
    [{:elvis, "~> 0.4.0", hex: :elvis_core}]
  end
end
