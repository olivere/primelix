defmodule Mix.Tasks.Rustyprimes do
  use Mix.Task

  @make_cmd "cd rustyprimes && cargo "

  @impl Mix.Task
  def run(args) do
    Mix.Shell.IO.info("------[ Compiling Rustyprimes ]---------")
    make = case args do
             [] ->
               @make_cmd <> " build"
             _ ->
               @make_cmd <> Enum.join(args, " ")
    end
    Mix.Shell.cmd(make, [], fn response -> IO.binwrite(response) end)
  end
end
