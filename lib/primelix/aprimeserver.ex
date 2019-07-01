defmodule Primelix.ArrayPrimeServer do
  use GenServer

  def gen_prime(max_num) do
    GenServer.call(__MODULE__, {:gen_prime, max_num}, :infinity)
  end

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl true
  def init(args) do
    {:ok, args}
  end

  @impl true
  def handle_call({:gen_prime, max_num}, _from, state) do
    array = :array.new(size: max_num + 1, fixed: true, default: false)
    array = :array.set(1, false, array)
    array = :array.set(2, true, array)


    primes = sieve(array, 2, max_num)

    {:reply, primes, state}
  end

  # Stop and collect all primes if we have searched sqrt(max_num) far
  defp sieve(array, current_num, max_num) when current_num * current_num > max_num do
    :array.sparse_foldr(fn(prime, _, acc) -> [prime | acc] end, [], array)
  end

  defp sieve(array, current_num, max_num) do
    new_array = if :array.get(current_num, array) == true do
      # found a prime: mark multiples of prime
      mark_multiples(array, 2 * current_num, current_num, max_num)
    else
      array
    end

    sieve(new_array, current_num + 1, max_num)
  end

  defp mark_multiples(array, next_multiple, _step, max_num) when next_multiple > max_num, do: array

  defp mark_multiples(array, next_multiple, step, max_num) do
    array = :array.set(next_multiple, false, array)
    mark_multiples(array, next_multiple + step, step, max_num)
  end
end
