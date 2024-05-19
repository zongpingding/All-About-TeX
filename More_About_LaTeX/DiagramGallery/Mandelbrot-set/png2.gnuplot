set term png size 2000, 2000
set output "mandelbrot.png"
set grid
set pm3d map
set size square
set palette defined (0 "black", 3 "red", 5 "white")
splot "data.txt"