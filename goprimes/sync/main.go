package main // import "alt-f4.de/primelix/goprimes/sync"

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
)

func main() {
	/* Uncomment this to test the restart mechanisms of the BEAM
	time.Sleep(2 * time.Second)
	os.Exit(1)
	//*/

	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		max, err := strconv.ParseInt(scanner.Text(), 10, 64)
		if err != nil {
			fmt.Println("[error: Bad Input]")
			os.Exit(1)
		}
		sieve(max)
	}
	if err := scanner.Err(); err != nil {
		fmt.Println("[error: Bad Input]")
		os.Exit(1)
	}
}

func sieve(max int64) {
	vec := make([]bool, max)
	n := int64(math.Sqrt(float64(max)))

	for i := int64(2); i < n; i++ {
		if !vec[i] {
			for j := 2 * i; j < max; j += i {
				vec[j] = true
			}
		}
	}

	fmt.Print("[ok: ")

	for i := int64(2); i < max; i++ {
		if !vec[i] {
			if i > int64(2) {
				fmt.Print(",")
			}
			fmt.Print(i)
		}
	}
	fmt.Println("]")
}
