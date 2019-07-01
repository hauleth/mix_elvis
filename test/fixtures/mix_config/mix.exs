defmodule MixConfig.MixProject do
  use Mix.Project

  def project do
    [
      app: :mix_config,
      version: "0.1.0",
      elvis: [
        %{
          dirs: ['.'],
          filter: '*.erl',
          rules: [
            {:elvis_style, :no_tabs, :disable}
          ],
          ruleset: :erl_files
        }
      ],
      deps: []
    ]
  end
end
