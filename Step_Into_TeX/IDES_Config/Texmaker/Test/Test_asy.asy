// 线性规划模型
size(250, 250);
draw((0, -2.5)--(0, 12), Arrow);
draw((-2.5, 0)--(12, 0), Arrow);
label("$o$", (-0.5, -0.5));
import graph;
real f(real x) {
    return 1/2*x;
}
draw(graph(f, 0, 10), red);
dot((10, 5), red);
draw((10, 5)--(10, 0), dashed);
label("$A(10, 5)$", (10, 5.5));
real g(real x){
    return 1/4*(36-4*x);
}
draw(graph(g, -1, 10.5), paleblue);
label("$B(0, 9)$", (1.1, 9));
label("$C(9, 0)$", (9, 0.5));
dot((0, 9), paleblue);
dot((9, 0), paleblue);
real h(real x){
    return 1/8*(48-6*x);
}
draw(graph(h, -1, 10), green);
dot((0, 6), green);
label("$D(0, 6)$", (-1.1, 6));
label("$E(8, 0)$", (8, -0.5));
dot((8, 0), green);
label("$y = \frac{1}{8}(48-6x)$", (3.5, 4), green);
label("$y = \frac{1}{4}(36-4x)$", (4.5, 5), paleblue);
label("$y = \frac{1}{2}x$", (8, 4), red);
usepackage("ctex");
usepackage("tikz");
label("$\fbox{线性规划图解}$", (5, 10));
label("测试演示", (5, 7));


// Asy支持内联tikz绘图
/*label("
\begin{tikzpicture}
    \draw[blue, dashed](0,0)--(1,0)--(1, 1)--(0, 1)--cycle;
\end{tikzpicture}
");
*/
//draw((2.5, 9.5)--(8, 9.5)--(8, 10)--(3, 10)--cycle);

