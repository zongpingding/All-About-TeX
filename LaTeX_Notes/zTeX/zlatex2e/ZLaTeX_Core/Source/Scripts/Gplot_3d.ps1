#####  7.Gnuplot绘图封装  #####
# cd C:\Users\PC\Desktop

# 3维函数绘图命令
# 1. 首先修改文件
function Gplot_3d_change_Text {
    param (
        [string]$f
    )
    sed -i "34s|f(x, y) = .*|f(x, y) = $f|" C:/BIN/Gplot_3d.gp
}
# 2.然后调用gnuplot进行绘制
function Gplot_3d{
    Gplot_3d_change_Text -f $args 
    # The output file will be in path that you run the following cmd
    gnuplot C:/BIN/Gplot_3d.gp
    mv Function_output_3d.pdf ./gnuoutput -force
    # echo "The 3d Function Graphic(pdf) has Successfully Created,`r`nwhich name is 'Function_output_3d.pdf' as default.`r`nIt Will be automatic opened by Your default pdf_reader ..."
}

# 外部调用时的参数传递
Gplot_3d $args[0]