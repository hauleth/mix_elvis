defmodule Mix.Tasks.ElvisTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  defp in_project(name, fun) do
    Mix.Project.in_project(name, "test/fixtures/#{name}", fn _ ->
      fun.()
    end)
  end

  for type <- ~w[mix_config elvis_config]a do
    test "#{type}" do
      in_project(unquote(type), fn ->
        output =
          capture_io(fn ->
            assert_raise Mix.Error, fn ->
              Mix.Task.run(:elvis)
            end
          end)

        refute output =~ ~r/no_tabs/
        assert output =~ ~r/no_trailing_whitespace/
      end)
    end
  end
end
