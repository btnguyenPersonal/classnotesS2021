#include <stdio.h>
int main() {
  int numValid = 0;
  int NUM_COLORS = 4;
  for (int T = 0; T < NUM_COLORS; T++) {
    for (int SA = 0; SA < NUM_COLORS; SA++) {
      for (int WA = 0; WA < NUM_COLORS; WA++) {
        for (int NT = 0; NT < NUM_COLORS; NT++) {
          for (int Q = 0; Q < NUM_COLORS; Q++) {
            for (int NSW = 0; NSW < NUM_COLORS; NSW++) {
              for (int V = 0; V < NUM_COLORS; V++) {
                if (WA != NT 
                    && WA != SA 
                    && NT != SA
                    && SA != Q
                    && NT != Q
                    && Q != NSW
                    && SA != NSW
                    && V != NSW
                    && V != SA) {
                  numValid++;
                }
              }
            }
          }
        }
      }
    }
  }
  printf("%d\n", numValid);
}
