set terminal pdfcairo enhanced color size 8,8 font "Times New Roman, 14"
set output "Gratitude_Final.pdf"
# 一般set isosamples 用于二维函数x，y方向的点数指定
# 一般set samples 用于一维函数的数据指定
# set samples 5
set isosamples 50

# 坐标轴标签
set xlabel 'x'
set ylabel 'y'
set zlabel 'z'

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
set yr [-1:1]


# 绘制3D函数
f(x, y) = sin(x*y)
splot f(x, y)


# 绘制结束后暂停展示
# pause -1





