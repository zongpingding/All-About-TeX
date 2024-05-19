// Baisc Output Settings
// 1. vector output format, default reader=-1
settings.render = 0;
settings.outformat = "pdf";
// 2. if interactive in adobe acrobat
settings.prc = false;



// Example 01:XY Plane
// import three;
// size(100);
// path3 g=(1,0,0)..(0,1,0)..(-1,0,0)..(0,-1,0)..cycle;
// draw(g);
// draw(O--Z,red+dashed,Arrow3);
// draw(((-1,-1,0)--(1,-1,0)--(1,1,0)--(-1,1,0)--cycle));
// dot(g,red);



// Example 02:Riemann Surface
// import graph3;
// import palette;
// size(200,300,keepAspect=false);
// currentprojection=orthographic(10,10,30);
// currentlight=(10,10,5);
// triple f(pair t) {
// 	return (exp(t.x)*cos(t.y),exp(t.x)*sin(t.y),t.y);
// }
// surface s=surface(f,(-4,-2pi),(0,4pi),8,16,Spline);
// s.colors(palette(s.map(zpart),Rainbow()));
// draw(s,render(merge=true));



// Example 03:Elevation
// import graph3;
// import grid3;
// import palette;
// currentprojection=orthographic(0.8,1,1);
// size(400,300,IgnoreAspect);
// defaultrender.merge=true;
// real f(pair z) {
// 	return cos(2*pi*z.x)*sin(2*pi*z.y);
// }
// surface s=surface(f,(-1/2,-1/2),(1/2,1/2),50,Spline);
// draw(s,mean(palette(s.map(zpart),Rainbow(40))),black);
// grid3(XYZgrid);



// Example 04:cylindrical coordinate
// import three;
// import math;
// texpreamble("\usepackage{bm}");
// size(300,0);
// pen thickp=linewidth(0.5mm);
// real rho=1, phi=60, z=0.8;
// currentprojection=orthographic((4,1,2));
// draw(
// 	unitcylinder,
// 	material(palegray+opacity(0.25),shininess=0.5)
// );
// real r=1.1;
// pen p=black;
// draw(Label("$x$",1),O--r*X,p,Arrow3);
// draw(Label("$y$",1),O--r*Y,p,Arrow3);
// draw(Label("$z$",1),O--r*Z,p,Arrow3);
// label("$\rm O$",(0,0,0),-1.5Y-X);
// triple Q=(rho*Cos(phi), rho*Sin(phi), z);
// dot("$(x,y,z)$",Q);
// draw(Q--(Q.x,Q.y,0),dashed+blue);
// draw(O--rho*dir(90,phi),dashed+blue);
// draw((0,0,Q.z)--Q,dashed+blue);
// draw(
// 	"$\varphi$",
// 	arc(O,0.15*X,0.15*dir(90,phi)),
// 	align=6*dir(90,phi/3)+Z,
// 	Arrow3
// );
// draw(
// 	"$\rho$",
// 	(0,0,0)--(Q.x,Q.y,0),
// 	align=-Y+2X,
// 	DotMargin3
// );
// draw(
// 	"$\bm{r}$",
// 	O--Q,
// 	align=2*dir(90,phi),
// 	Arrow3,
// 	DotMargin3
// );



// Example 05:extrudedcontour
// import contour;
// import palette;
// import graph3;
// defaultrender.merge=true;
// currentprojection=orthographic(25,10,10);
// size(0,12cm);
// real a=3;
// real b=4;
// real f(pair z) {return (z.x+z.y)/(2+cos(z.x)*sin(z.y));}
// guide[][] g=contour(f,(-10,-10),(10,10),new real[]{8},150);
// for(guide p:g[0]){
// 	draw(extrude(p,8Z),palered);
// 	draw(path3(p),red+2pt);
// }
// draw(lift(f,g),red+2pt);
// surface s=surface(f,(0,0),(10,10),20,Spline);
// s.colors(palette(s.map(zpart),Rainbow()+opacity(0.5)));
// draw(s);
// axes3("$x$","$y$","$z$",Arrow3);



// Example 06:exip
// import graph3;
// texpreamble("\usepackage[lite,subscriptcorrection,slantedGreek,nofontinfo]{mtpro2}");
// size(200,200,IgnoreAspect);
// currentprojection=perspective(2,4,2);
// real f(pair z) {
// 	return z.y^2/5 - z.x*z.y + 1;
// }
// real g(pair z) {
// 	return 2;
// }
// draw(
// 	surface(f,(-2,-2),(2,2),nx=10,Spline),
// 	red,
// 	render(merge=true)
// );
// draw(
// 	surface(g,(-2,-2),(2,2),nx=10,Spline),
// 	green,
// 	render(merge=true)
// );
// draw(Label("$x$",1),(-6,0,0)--(6,0,0),red,Arrow3);
// draw(Label("$y$",1),(0,-6,0)--(0,6,0),red,Arrow3);
// draw(Label("$z$",1),(0,0,-6)--(0,0,6),red,Arrow3);
// label("$z=\frac{1}{5}y^3 - xy$",(1,1,1),NE);








