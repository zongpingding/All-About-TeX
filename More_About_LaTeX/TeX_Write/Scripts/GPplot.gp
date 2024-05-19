# 终端与文件设置
set terminal pdfcairo enhanced color size 8,8 font "Times New Roman, 14"
set output "./Param_Function_output.pdf"
set isosamples 50


# 坐标轴标签
set xlabel 'x'
set ylabel 'y'
set zlabel 'z'
set view 75,336

# 设置图注
unset key
set xyplane at 0
# 是否隐藏不可见部分，以及透明度
set hidden3d
set style fill transparent solid .4
# 设置色谱
set pm3d
# set pm3d scansbackward
set palette rgbformulae 22,13,-31
# 隐藏色标 --> colormap
unset colorbox


# 设置为参数方程绘图模式
set parametric
# 设置坐标轴刻度的缩放比例
set tics scale 1,1,1


# 参数范围
set urange [0:2*pi]
set vrange [0:2*pi]
set zr [-4.5:4.5]


# 绘制参数方程（下面有一些样例）
# splot 1*cos(u)*cos(v), 3*cos(u)*sin(v), 2*sin(u)
# splot 3*tan(v)*cos(u), 1*tan(v)*sin(u), 1*(1/cos(v))
splot 4*cos(u)*cos(v), 4*cos(u)*sin(v), 4*sin(u)

# 暂停查看
# pause -1


# 取消输出
unset out
