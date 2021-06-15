#include <stdio.h>
#include <stdint.h>

void main(void){
  register int32_t a, b, c;

  while(1)
    for(a = 0; a < 3; a++)
      for(b = 0; b < 3; b++)
        for(c = 0; c < 3; c++)
          printf("a = %d, b = %d, c = %d\n", a, b, c);           
} // main