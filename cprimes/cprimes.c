#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void sieve (unsigned long int max_num) {
  unsigned char *restrict numbers = NULL;
  unsigned long i,j;

  numbers = calloc(sizeof(unsigned char), max_num);

  /* This is the actual sieve !!! */

  for (i = 2; i < sqrt(max_num); i++) {
    if (numbers[i] == 0) {
      for(j = 2*i; j < max_num; j+=i) {
        numbers[j] = 1;
      }
    }
  }


  printf("[ok: ");

  for(i = 2; i < max_num; i++) {
    if (numbers[i] == 0) {
      if (i > 2) {
        printf(",");
      }

      printf("%lu", i);
    }
  }

  printf("]");
  free(numbers);
  fflush(stdout);
}

int main () {
  unsigned long int max_num;

  /* Uncomment this to test the restart mechanisms of the BEAM
  sleep(2);
  exit(-1);
  */

  while (42) {
    /* fprintf(stderr, "Waiting for Input:"); */

    if (scanf("%lu", &max_num) != EOF) { 
      /* fprintf(stderr, "Read %lu from stdin.", max_num); */
      sieve(max_num);
    } else {
      exit(0);
    }

    /* Clear the input buffer */
    while ((getchar()) != '\n'); 
  }

  return 0;
}
