defmodule Mix.Tasks.Goprimes do
  use Mix.Task

  @make_cmd "cd goprimes && make "

  @impl Mix.Task
  def run(args) do
    Mix.Shell.IO.info("--------[ Compiling GoPrimes: ]----------")
    make = @make_cmd <> Enum.join(args, " ")
    Mix.Shell.cmd(make, [], fn response -> IO.binwrite(response) end)
  end
end
