defmodule MixElvis.MixProject do
  use Mix.Project

  def project do
    [
      app: :mix_elvis,
      version: "0.1.0",
      elixir: "~> 1.6",
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:elvis, "~> 0.5.0", hex: :elvis_core},
      {:ex_doc, ">= 0.0.0", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      description: "Run Elvis linter for project that are using Mix",
      links: %{
        "GitHub" => "https://github.com/hauleth/mix_elvis"
      }
    ]
  end
end
