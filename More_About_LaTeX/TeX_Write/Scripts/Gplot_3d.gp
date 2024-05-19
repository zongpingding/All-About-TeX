set terminal pdfcairo enhanced color size 8,8 font "Times New Roman, 14"
set output "./Function_output_3d.pdf"
# 一般set isosamples 用于二维函数x，y方向的点数指定
# 一般set samples 用于一维函数的数据指定
# set samples 5
set isosamples 50

# 坐标轴标签
set xlabel 'x'
set ylabel 'y'
set zlabel 'z'
set view 75,336

# 设置图注
unset key
set xyplane at 0
# 是否隐藏不可见部分
set hidden3d


# 设置色谱
set pm3d
set palette rgbformulae 22,13,-31
# 隐藏色标 --> colormap
unset colorbox

# 设置绘制范围
set xr [-3:3]
set yr [-3:3]


# 绘制3D函数
# 乘方使用**, 而非^
f(x, y) = x**2-y**2-10
splot f(x, y)


unset out


# 绘制结束后暂停展示
# pause -1





