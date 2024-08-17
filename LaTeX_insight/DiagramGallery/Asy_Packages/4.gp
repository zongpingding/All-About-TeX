set terminal pdfcairo enhanced color size 8,8 font "Times New Roman, 14"
set output "./diable.pdf"



set pm3d
set view map
set size square
unset surface
set ytics 0.225,0.02,0.265
set xtics -0.745,0.02,-0.705
unset key
set logscale cb
blue = 2.0/3.0
green = 1.0/3.0
set palette model HSV defined \
    ( log(15) blue 0.7 0.6, log(50) blue 0.6 0.9, \
    log(100) green 0.5 1, log(200) green 0.7 0.5, \
    log(1000) green 0.9 0.4, log(5000) 0 0 1, \
    log(9900) 0 0 1, log(9901) 0 1 0, log(10000) 0 1 0 ) \
splot fractal