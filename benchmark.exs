max_num = 100_000
benchmark = %{
  "elixir_primes_array" => fn -> Primelix.ArrayPrimeServer.gen_prime(max_num) end,
  "elixir_primes_bitvector" => fn -> Primelix.PrimeServer.gen_prime(max_num) end,
  "c_primes" => fn -> Primelix.CPrimeServer.gen_prime(max_num) end,
  "rust_primes" => fn -> Primelix.RustyPrimeServer.gen_prime(max_num) end,
  "go_primes_sync" => fn -> Primelix.GoSyncPrimeServer.gen_prime(max_num) end,
  "go_primes_async" => fn -> Primelix.GoAsyncPrimeServer.gen_prime(max_num) end,
  "java_primes" => fn -> Primelix.JPrimeServer.gen_prime(max_num) end,
  "ruby_primes" => fn -> Primelix.RubyPrimeServer.gen_prime(max_num) end,
}

Benchee.run(benchmark)
