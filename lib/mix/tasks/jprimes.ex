defmodule Mix.Tasks.Jprimes do
  use Mix.Task

  @make_cmd "cd jprimes && javac JPrimes.java "

  @impl Mix.Task
  def run(args) do
    Mix.Shell.IO.info("--------[ Compiling JPrimes: ]----------")
    Mix.Shell.cmd(@make_cmd, [], fn response -> IO.binwrite(response) end)
  end
end
