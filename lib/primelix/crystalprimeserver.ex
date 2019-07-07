defmodule Primelix.CrystalPrimeServer do
  use GenServer

  defmodule CrystalPrimes do
    defstruct port: nil, monitor: nil
  end

  # TODO: make implementation more robust
  require IEx

  def gen_prime(max_num) do
    GenServer.call(__MODULE__, {:gen_prime, max_num})
  end

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl true
  def init(_args) do
    crystalprimes = start_port()
    {:ok, crystalprimes}
  end

  @impl true
  def handle_call({:gen_prime, max_num}, _from, crystalprimes) do
    max_num_string = Integer.to_string(max_num) <> "\n"
    send(crystalprimes.port, {self(), {:command, max_num_string}})
    primes = receive_primes(crystalprimes.port, [], "")
    {:reply, primes, crystalprimes}
  end

  @impl true
  def handle_info({:DOWN, _ref, :port, port, _reason}, crystalprimes) do
    if port == crystalprimes.port do
      new_crystalprimes = start_port()
      {:noreply, new_crystalprimes}
    else
      {:noreply, crystalprimes}
    end
  end

  defp start_port do
    port = Port.open({:spawn, "./crystalprimes/primes"}, [:binary])
    monitor = Port.monitor(port)
    %CrystalPrimes{port: port, monitor: monitor}
  end

  defp receive_primes(port, primes_so_far, last_string) do
    receive do
      {^port, {:data, data}} -> parse_primes(port, primes_so_far, last_string <> data)
    end
  end

  defp parse_primes(port, primes_so_far, "[ok: " <> data) do
    parse_primes(port, primes_so_far, data)
  end

  defp parse_primes(port, primes_so_far, data) do
    number_strings = String.split(data, ",")
    {last_string, number_strings_without_last} = number_strings  |> List.pop_at(-1)
    terminated = String.match?(last_string, ~r/.*\]$/)
    if terminated do
      convert_to_integer_list(primes_so_far, number_strings)
    else
      integer_list = convert_to_integer_list(primes_so_far, number_strings_without_last)
      receive_primes(port, integer_list, last_string)
    end
  end

  defp convert_to_integer_list(primes_so_far, number_strings_list) do
    more_primes = Enum.map(number_strings_list, fn number_string ->
      {num, _} = Integer.parse(number_string)
      num
    end)
    primes_so_far ++ Enum.to_list(more_primes)
  end
end
