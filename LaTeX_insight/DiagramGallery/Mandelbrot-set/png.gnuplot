set term png size 2000, 2000
set output "mandelbrot.png"
set grid
set pm3d map
set size square
set palette defined (0 "black", 1 "yellow", 2 "light-green", 3 "light-blue",4 "coral", \
    5 "gold", 6 "navy", 7 "purple", 8 "turquoise", 9 "red", 10 "white");
splot "data.txt"