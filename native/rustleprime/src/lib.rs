#[macro_use] extern crate rustler;
//#[macro_use] extern crate rustler_codegen;
//#[macro_use] extern crate lazy_static;

use rustler::{Env, Term, NifResult, Encoder};

mod atoms {
    rustler_atoms! {
        atom ok;
        //atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

rustler_export_nifs! {
    "Elixir.Primelix.RustlePrime",
    [("gen_prime", 1, sieve)],
    None
}

fn sieve<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let max_num: usize = args[0].decode()?;

    let mut numbers = vec![true; max_num];
    numbers.resize(max_num, true);

    let mut primes = Vec::new();

    for p in 2..max_num {
        if numbers[p] == true {
            for mult in (2*p..max_num).step_by(p) {
                numbers[mult] = false;
            }
        }
    }

    for idx in 2..max_num {
        if numbers[idx] == true {
            primes.push(idx);
        }
    }

    Ok((atoms::ok(), primes).encode(env))
}
