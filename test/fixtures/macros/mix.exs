defmodule Macros.MixProject do
  use Mix.Project

  def project do
    [
      app: :macros,
      version: "0.1.0",
      erlc_paths: ["."]
    ]
  end
end
