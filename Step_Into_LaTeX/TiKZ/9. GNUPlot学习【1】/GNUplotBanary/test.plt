set term tikz context size 5in,3in standalone createstyle
set output "fullpage-example.tex"
plot sin(x)
plot cos(atan(x))*sin(x)