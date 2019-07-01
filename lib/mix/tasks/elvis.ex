defmodule Mix.Tasks.Elvis do
  use Mix.Task

  @shortdoc "Run Elvis linter on Erlang files built with Mix."

  @recursive true

  @default_config_path "./elvis.config"

  @default_config [
    %{
      dirs: ['src'],
      include_dirs: ['include'],
      filter: '*.erl',
      ruleset: :erl_files
    },
    %{dirs: ['.'], filter: 'elvis.config', ruleset: :elvis_config}
  ]

  def run(_args) do
    Application.load(Mix.Project.get!())

    case :elvis_core.rock(config()) do
      :ok ->
        :ok

      _other ->
        Mix.raise("You have disappointed Elvis")
    end
  end

  defp config do
    with {:error, :enoent} <- elvis_file(),
         :error <- Keyword.fetch(Mix.Project.config(), :elvis),
         :error <- Application.fetch_env(:elvis, :config) do
      @default_config
    else
      {:ok, config} ->
        config

      {:error, reason} ->
        Mix.raise("Elvis failed with reason #{inspect(reason)}")
    end
  end

  defp elvis_file do
    with {:ok, [config]} <- :file.consult(@default_config_path) do
      {:ok, :elvis_config.load(config)}
    end
  end
end
