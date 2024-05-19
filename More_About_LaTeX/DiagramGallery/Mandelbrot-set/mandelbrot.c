#include <stdio.h>
#include <math.h>

#define r0  0.0
#define i0  0.0
#define range   1.0

#define nmax    20000
#define step    5000.0


double mandelbrot(double a, double b) {
    double x = 0.0;
    double y = 0.0;
    double x1, y1;

    int n;

    for (n = 1; n <= nmax; n++) {
        x1 = x * x - y * y + a;
        y1 = 2.0 * x * y + b;
        if (x1 * x1 + y1 * y1 > 4.0) {
            return log(n);
        }
        x = x1;
        y = y1;
    }
    return 0;
}


int main() {
    double i, j;

    for (i = r0 - range; i < r0 + range; i += 2.0 * range / step) {
        for (j = i0 - range; j < i0 + range; j += 2.0 * range / step) {
            printf("%1.14e %1.14e %1.14e\n", i, j, mandelbrot(i, j));
        }
        printf("\n");
    }
    return 0;
}