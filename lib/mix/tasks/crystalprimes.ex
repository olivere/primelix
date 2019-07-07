defmodule Mix.Tasks.Crystalprimes do
  use Mix.Task

  @make_cmd "cd crystalprimes && make "

  @impl Mix.Task
  def run(args) do
    Mix.Shell.IO.info("--------[ Compiling CrystalPrimes: ]----------")
    make = @make_cmd <> Enum.join(args, " ")
    Mix.Shell.cmd(make, [], fn response -> IO.binwrite(response) end)
  end
end
