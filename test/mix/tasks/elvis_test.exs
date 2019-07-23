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
            assert :error == run_elvis()
          end)

        refute output =~ ~r/no_tabs/
        assert output =~ ~r/no_trailing_whitespace/
      end)
    end
  end

  test "parseable output" do
    in_project(:mix_config, fn ->
      output = capture_io(fn -> run_elvis(["--format=parsable"]) end)

      assert output ==
               "mix_config.erl:6:no_trailing_whitespace:Line 6 has 2 trailing whitespace characters.\n"
    end)
  end

  test "fails when the format is unknown" do
    assert_raise Mix.Error, "Unknown format 'unknown'", fn ->
      Mix.Task.rerun(:elvis, ["--format=unknown"])
    end
  end

  test "default" do
    in_project(:default, fn ->
      output = capture_io(fn -> Mix.Task.run(:elvis) end)

      assert output == ""
    end)
  end

  test "macros names are ignored" do
    in_project(:macros, fn ->
      output = capture_io(fn -> Mix.Task.run(:elvis) end)

      assert "" == output
    end)
  end

  defp run_elvis(args \\ []) do
    Mix.Task.rerun(:elvis, args)

    :ok
  rescue
    Mix.Error -> :error
  end
end
