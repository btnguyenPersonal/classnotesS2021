#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  printf("code %p\n", main);
  printf("heap %p\n", malloc(1));
  printf("stack %p\n", &argc[1]);
  return 0;
}

