max_num = 100_000
benchmark = %{
  "elixir_primes_array" => fn -> Primelix.ArrayPrimeServer.gen_prime(max_num) end,
  "elixir_primes_bitvector" => fn -> Primelix.PrimeServer.gen_prime(max_num) end,
  "c_primes" => fn -> Primelix.CPrimeServer.gen_prime(max_num) end,
  "rust_primes" => fn -> Primelix.RustyPrimeServer.gen_prime(max_num) end,
}

Benchee.run(benchmark)
