defmodule Mix.Tasks.Swiftprimes do
  use Mix.Task

  @make_cmd "cd swiftprimes && swift build -c release "

  @impl Mix.Task
  def run(args) do
    Mix.Shell.IO.info("--------[ Compiling SwiftPrimes: ]----------")
    make = @make_cmd <> Enum.join(args, " ")
    Mix.Shell.cmd(make, [], fn response -> IO.binwrite(response) end)
  end
end
