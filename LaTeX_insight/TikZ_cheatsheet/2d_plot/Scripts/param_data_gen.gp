set table "./2d_plot/gnuplot_output_data/param_data_gen.table"
set format "%.5f"
set samples 500
set parametric


# specific a parametric function
set trange [0:2*pi]
plot 7*sin(t), 4*cos(t)