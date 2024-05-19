settings.outformat="pdf";
settings.render=0;
settings.prc=true;


real iterate(pair z, pair c, int N) {
    pair zsquare = 0;

    int n = 0;

    do {
        zsquare = (z.x * z.x, z.y * z.y);
        z = (zsquare.x + zsquare.y * -1, 2 * z.x * z.y) + c;
        ++n;
    }
    while (zsquare.x + zsquare.y < 4 && n < N);

    zsquare = (z.x * z.x, z.y * z.y);
    // return n - log(.5 * log(zsquare.x + zsquare.y) / log(N)) / log(2);

    return n;
}

void mandelbrot(pair size, real zoom, pair pos, int N) {
    for(int x = 0; x < size.x; ++x) {
        for(int y = 0; y < size.y; ++y) {
            pair z = (x / size.x, y / size.y) * zoom - pos;

            real res = iterate(z, z, N) / N;

            fill(box((x, y), (x + 2, y + 2)), rgb(sin(res * 4), sin(res * 5), sin(res * 6)));
        }
    }
}

mandelbrot((300, 300), 3, (2, 1.5), 128);