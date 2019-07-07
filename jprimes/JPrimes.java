import java.util.Scanner;
import java.util.Formatter;

public class JPrimes {

    public static void sieve(int max_num) {
        boolean[] numbers = new boolean[max_num];

        for (int i = 2; i < Math.sqrt(max_num); i++) {
            if (numbers[i] == false) {
                for (int j = 2*i; j < max_num; j += i) {
                    numbers[j] = true;
                }
            }
        }

        StringBuilder sb = new StringBuilder();
        Formatter fmt = new Formatter(sb);

        fmt.format("[ok: ");

        for (int i = 2; i < max_num; i++) {
            if (numbers[i] == false) {
                if (i > 2) {
                    fmt.format(",");
                }

                fmt.format("%d", i);
            }
        }

        fmt.format("]");

        System.out.print(sb.toString());
        System.out.flush();
    }

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);

        while (true) {
            try {
                int max_num = in.nextInt();
                sieve(max_num);
            } catch (java.util.NoSuchElementException nsex) {
                System.exit(0);
            }
        }
    }

}
