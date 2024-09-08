# 警告
# 尽量绘制完成后修改一下，然后全屏模式下保存为pdf

# set term pdfcairo font 'Times New Roman, 12'
# set out './Function_output_2d.pdf'

set encoding utf8

# 增加函数绘制的采样点,使之变得光滑
set samples 1000


# 边框设置
unset border
set xzeroaxis linetype 1 lc 'black' lw 1
set yzeroaxis linetype 1 lc 'black' lw 1

# 设置刻度间距为1 
set autoscale xy
set xtics 1 nomirror axis
set ytics 1 nomirror axis




# 坐标轴设置
set yr []
set arrow from graph 0, first 0 to graph 1, first 0 head filled size screen 0.01, 6 
set arrow from first 0, graph 0 to first 0, graph 1 head filled size screen 0.01, 6 
set size ratio 1

# 额外的xrange设置
# set xr [-5:5]

# 欲绘制的函数
unset key
f(x) = x**2
plot f(x) noti lc 'orange'


# unset out


# 暂停修改
pause -1
