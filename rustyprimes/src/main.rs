use std::io::{self, BufRead, Write};

fn main() {
    let stdin = io::stdin();
    for line in stdin.lock().lines() {
        let input = line.unwrap();
        match input.parse::<u32>() {
            Ok(max_num) => sieve(max_num as usize),
            Err(_) => print!("[error: Bad Input]"),
        }
    }
}

fn sieve(max_num: usize) {
    let mut numbers = Vec::with_capacity(max_num);
    numbers.resize(max_num, 1);

    for p in 2..max_num {
        if numbers[p] == 1 {
            for mult in (2*p..max_num).step_by(p) {
                numbers[mult] = 0;
            }
        }
    }

    print!("[ok: ");
    let mut first_prime = true;

    for idx in 2..max_num {
        if numbers[idx] == 1 {
            if first_prime {
                first_prime = false;
            } else {
                print!(",");
            }

            print!("{}", idx);
        }
    }

    print!("]");
    let stdout = io::stdout();
    stdout.lock().flush().unwrap();
}

