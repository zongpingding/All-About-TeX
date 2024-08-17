set terminal pdfcairo enhanced color size 8,8 font "Times New Roman, 14"
set output "./diable.pdf"

f(x,y) = y**4 - x**4 - 48*y**2 + 50*x**2
set xrange [-15:15]; set yrange [-15:15]
set samples 1000
set isosample 1000,1000
set view 0,0
set size square
unset key; unset ztics; unset xtics; unset ytics; unset border;
set cntrparam levels incremental -40,10,40
set contour base
unset surface
splot f(x,y)
