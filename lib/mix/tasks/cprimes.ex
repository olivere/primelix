defmodule Mix.Tasks.Cprimes do
  use Mix.Task

  @make_cmd "cd cprimes && make "

  @impl Mix.Task
  def run(args) do
    Mix.Shell.IO.info("--------[ Compiling CPrimes: ]----------")
    make = @make_cmd <> Enum.join(args, " ")
    Mix.Shell.cmd(make, [], fn response -> IO.binwrite(response) end)
  end
end
