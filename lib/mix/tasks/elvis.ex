defmodule Mix.Tasks.Elvis do
  use Mix.Task

  @shortdoc "Run Elvis linter on Erlang files built with Mix."

  @recursive true

  @default_config [
    %{
      dirs: ['src'],
      include_dirs: ['include'],
      filter: '*.erl',
      ruleset: :erl_files
    },
    %{dirs: ['.'], filter: 'elvis.config', ruleset: :elvis_config}
  ]

  @options [
    format: :string
  ]

  def run(argv) do
    {options, _argv, _errors} = OptionParser.parse(argv, strict: @options)

    Application.put_env(:elvis, :output_format, format(options[:format]))

    case :elvis_core.rock(config()) do
      :ok ->
        :ok

      _other ->
        Mix.raise("You have disappointed Elvis")
    end
  end

  defp format(nil), do: if(IO.ANSI.enabled?(), do: :colors, else: :plain)
  defp format("color"), do: :colors
  defp format("colors"), do: :colors
  defp format("plain"), do: :plain
  defp format(format) when format in ~w[parsable parseable flycheck], do: :parsable
  defp format(other), do: Mix.raise("Unknown format '#{other}'")

  defp config do
    with :error <- Keyword.fetch(Mix.Project.config(), :elvis),
         [] <- :elvis_config.default() do
      @default_config
    else
      config when is_list(config) ->
        config

      {:ok, config} ->
        config

      {:error, reason} ->
        Mix.raise("Elvis failed with reason #{inspect(reason)}")
    end
  end
end
