set table "./2d_plot/gnuplot_output_data/data_gen.table"
set format "%.5f"
set samples 500


# specific a 2d function
f(x) = 3*sin(1/x)
set xr [-6:-1]
plot f(x)
