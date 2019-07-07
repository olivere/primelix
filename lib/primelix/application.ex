defmodule Primelix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Primelix.Worker.start_link(arg)
      # {Primelix.Worker, arg}
      {Primelix.PrimeServer, []},
      {Primelix.ArrayPrimeServer, []},
      {Primelix.CPrimeServer, []},
      {Primelix.RustyPrimeServer, []},
      {Primelix.GoSyncPrimeServer, []},
      {Primelix.GoAsyncPrimeServer, []},
      {Primelix.JPrimeServer, []},
      {Primelix.RubyPrimeServer, []},
      {Primelix.CrystalPrimeServer, []},
      {Primelix.SwiftPrimeServer, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Primelix.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
