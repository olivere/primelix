import Foundation

func sieve(max: Int) {
    var primes = Array(repeating: true, count: max+1)
    let n = Int(Double(max).squareRoot())
    for i in 2..<n where primes[i] {
        for j in stride(from: 2*i, through: max, by: i) {
            primes[j] = false
        }
    }

    var out: String = "[ok: "
    for i in 2..<max where primes[i] {
        if i > 2 {
            out.append(",")
        }
        out.append("\(i)")
    }
    out.append("]")
    print(out)
}

if let line = readLine() {
    if let max = Int(line) {
        sieve(max: max)
    } else {
        print("[error: Bad Input]")
        exit(1)
    }
}
