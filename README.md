# Primelix

This project's major goal is to benchmark the runtime overhead of the BEAM.
It also is meant as a testbed for experimenting with the BEAM Port system.

```
+------+
| BEAM |---[Port A]---> [External Process A]
|      |
|      |---[Port B]---> [External Process B]
+------+
```

The BEAM Port system offers a fault-tolerant interface to functionality that
is written in another language. A BEAM-internal Process can monitor the external 
one and restart it when necessary.

But foreign-code interfacing always comes with a cost. Because converting data
from and to the external process can be expensive. To make the benchmark representative
I have created it to be end-to-end; i.e.: from the BEAM to the external process 
and back again.


# Caveat Emptor

If have used the calculation of prime numbers as a cpu bound task that can be easily
implemented in other languages and frameworks. Beware: the implementation might
be a bit naive. Especially the conversion can be improved by switching to a 
pure binary format; I'm curious whether this will change the results significantly.


# Seeing for yourself

I have published it here for comparison and so you can recreate it on your
machine. I have used Elixir 1.8.1 on Erlang 21.3.2 but it might run on older
Versions. Your mileage may vary. You should have installed the `Mix` Toolchain
together with your Elixir version. Mix is required for conveniently building and
running this experiment.

To compile all sources you need a `gcc` + `make` and `rust` + `cargo` toolchain
installed. I have used `rustc` and `cargo` in version `1.35.0` and `gcc` in
version `8.2.1` with GNU `make` in version `4.2.1`. You can try to compile all
the sources with older versions than the mentioned ones, but I cannot give any
assumptions regarding your success.

If all the prerequisites are met you can run the benchmark using `mix benchmark`.
This is an alias that will execute the following Mix tasks (in that order):
```
mix deps.get           # installs the Elixir dependencies
mix compile            # compiles the Elixir sources
mix cprimes            # compiles the C implementation
mix rustyprimes        # compiles the Rust implementation 
mix run benchmark.exs  # runs the benchmark and prints results
```

# License 

This project is published under the `The 3-Clause BSD License`. See `LICENSE.md`
for details.
