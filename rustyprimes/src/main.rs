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
    let mut numbers = vec![true; max_num];
    numbers.resize(max_num, true);

    for p in 2..max_num {
        if numbers[p] == true {
            for mult in (2*p..max_num).step_by(p) {
                numbers[mult] = false;
            }
        }
    }

    let stdout = io::stdout();
    let mut writer = stdout.lock();
    //let mut handle = io::BufWriter::new(stdout);

    write!(writer, "[ok: ").unwrap();
    let mut first_prime = true;

    for idx in 2..max_num {
        if numbers[idx] == true {
            if first_prime {
                first_prime = false;
            } else {
                write!(writer, ",").unwrap();
            }

            write!(writer, "{}", idx).unwrap();
        }
    }

    write!(writer, "]").unwrap();
    writer.flush().unwrap();
}

