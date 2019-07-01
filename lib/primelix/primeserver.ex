defmodule Primelix.PrimeServer do
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
    new_bitmap = Bitmap.new(max_num + 1)
    filled_bitmap = Enum.reduce(2..max_num, new_bitmap, fn (number, outer_bitmap) ->
      double = number * 2
      if double <= max_num and Bitmap.set?(outer_bitmap, number) do
        multiples = Stream.take_every(double..max_num, number)
        Enum.reduce(multiples, outer_bitmap, fn (multiple, inner_bitmap) ->
          Bitmap.set(inner_bitmap, multiple)
        end)
      else
        outer_bitmap
      end
    end)

    primes = Enum.reduce(2..max_num, [], fn (number, primes) ->
      if Bitmap.unset?(filled_bitmap, number) do
        [number | primes]
      else
        primes
      end
    end)

    {:reply, Enum.reverse(primes), state}
  end

end
