// Baisc Output Settings
// 1. vector output format, default reader=-1
settings.render = 0;
settings.outformat = "pdf";
// 2. if interactive in adobe acrobat
settings.prc = false;



// Example 01:2-D flowchart
// size(0,22cm);
// texpreamble("
// 	\usepackage{bm}
// 	\def\v{\bm}
// 	\def\grad{\v\nabla}
// 	\def\cross{{\v\times}}
// 	\def\curl{\grad\cross}
// 	\def\del{\nabla}
// ");
// defaultpen(fontsize(10pt));
// real margin=1.5mm;
// object IC=draw("initial condition $\v U_0$",box,(0,1),
// 		margin,black,FillDraw(palegray));
// object Adv0=draw("Lagrangian state $\v U(t)$",ellipse,(1,1),
// 		margin,red,FillDraw(palered));
// object Adv=draw("Lagrangian prediction $\v U(t+\tau)$",ellipse,(1,0),
// 		margin,red,FillDraw(palered));
// object AdvD=draw("diffused parcels",ellipse,(1.8,1),
// 		margin,red,FillDraw(palered));
// object Ur=draw("rearranged $\v \widetilde U$",box,(0,0),
// 		margin,orange+gray,FillDraw(paleyellow));
// object Ui=draw("interpolated $\v \widetilde U$",box,(1,-1),
// 		margin,blue,FillDraw(paleblue));
// object Crank=draw("${\cal L}^{-1}(-\tau){\cal L}(\tau)\v \widetilde U$",
// 		box,(0.5,-1),margin,blue,FillDraw(paleblue));
// object CrankR=draw("${\cal L}^{-1}(-\tau){\cal L}(\tau)\v \widetilde U$",
// 		box,(0,-1),margin,orange+gray,FillDraw(paleyellow));
// object Urout=draw(minipage("\center{Lagrangian rearranged solution~$\v U_R$}",
// 				100pt),box,(0,-2),margin,orange+gray,
// 		FillDraw(paleyellow));
// object Diff=draw("$\v D\del^2 \v \widetilde U$",box,(0.75,-1.5),
// 		margin,blue,FillDraw(paleblue));
// object UIout=draw(minipage("\center{semi-Lagrangian solution~$\v U_I$}",80pt),
// 		box,(0.5,-2),margin,FillDraw(palered+paleyellow));
// object psi=draw("$\psi=\del^{-2}\omega$",box,(1.6,-1),
// 		margin,darkgreen,FillDraw(palegreen));
// object vel=draw("$\v v=\v{\hat z} \cross\grad\psi$",box,(1.6,-0.5),
// 		margin,darkgreen,FillDraw(palegreen));
// add(new void(frame f, transform t) {
// 	pair padv=0.5*(point(Adv0,S,t)+point(Adv,N,t));
// 	picture pic;
// 	draw(pic,"initialize",point(IC,E,t)--point(Adv0,W,t),RightSide,Arrow,
// 		PenMargin);
// 	draw(pic,minipage("\flushright{advect: Runge-Kutta}",80pt),
// 		point(Adv0,S,t)--point(Adv,N,t),RightSide,red,Arrow,PenMargin);
// 	draw(pic,Label("Lagrange $\rightarrow$ Euler",0.45),
// 		point(Adv,W,t)--point(Ur,E,t),5LeftSide,orange+gray,
// 		Arrow,PenMargin);
// 	draw(pic,"Lagrange $\rightarrow$ Euler",point(Adv,S,t)--point(Ui,N,t),
// 		RightSide,blue,Arrow,PenMargin);
// 	draw(pic,point(Adv,E,t)--(point(AdvD,S,t).x,point(Adv,E,t).y),red,
// 		Arrow(Relative(0.7)),PenMargin);
// 	draw(pic,minipage("\flushleft{diffuse: multigrid Crank--Nicholson}",80pt),
// 		point(Ui,W,t)--point(Crank,E,t),5N,blue,MidArrow,PenMargin);
// 	draw(pic,minipage("\flushleft{diffuse: multigrid Crank--Nicholson}",80pt),
// 		point(Ur,S,t)--point(CrankR,N,t),LeftSide,orange+gray,Arrow,PenMargin);
// 	draw(pic,"output",point(CrankR,S,t)--point(Urout,N,t),RightSide,
// 		orange+gray,Arrow,PenMargin);
// 	draw(pic,point(Ui,S,t)--point(Diff,N,t),blue,MidArrow,PenMargin);
// 	draw(pic,point(Crank,S,t)--point(Diff,N,t),blue,MidArrow,PenMargin);
// 	label(pic,"subtract",point(Diff,N,t),12N,blue);
// 	draw(pic,Label("Euler $\rightarrow$ Lagrange",0.5),
// 		point(Diff,E,t)--(point(AdvD,S,t).x,point(Diff,E,t).y)--
// 		(point(AdvD,S,t).x,point(Adv,E,t).y),RightSide,blue,
// 		Arrow(position=1.5),PenMargin);
// 	dot(pic,(point(AdvD,S,t).x,point(Adv,E,t).y),red);
// 	draw(pic,(point(AdvD,S,t).x,point(Adv,E,t).y)--point(AdvD,S,t),red,Arrow,
// 		PenMargin);
// 	draw(pic,"output",point(Crank,S,t)--point(UIout,N,t),RightSide,brown,Arrow,
// 		PenMargin);
// 	draw(pic,Label("$t+\tau\rightarrow t$",0.45),
// 		point(AdvD,W,t)--point(Adv0,E,t),2.5LeftSide,red,Arrow,PenMargin);
// 	draw(pic,point(psi,N,t)--point(vel,S,t),darkgreen,Arrow,PenMargin);
// 	draw(pic,Label("self-advection",4.5),point(vel,N,t)--
// 		arc((point(vel,N,t).x,point(Adv,E,t).y),5,270,90)--
// 		(point(vel,N,t).x,padv.y)--
// 		padv,LeftSide,darkgreen,Arrow,PenMargin);
// 	draw(pic,Label("multigrid",0.5,S),point(Ui,E,t)--point(psi,W,t),darkgreen,
// 		Arrow,PenMargin);

// 	add(f,pic.fit());
// });





// Example 02:limits
// size(200,200,IgnoreAspect);
// import graph;

// real L=1;
// real epsilon=0.25;
// real a(int n) {return L+1/n;}

// for(int i=1; i < 20; ++i)
//     dot((i,a(i)));
// real N=1/epsilon;

// xaxis(Label("$n$",align=2S));
// yaxis(Label("$a_n$",0.85));

// xtick("$2$",2);
// ytick("$\frac{3}{2}$",3/2);
// ytick("$2$",2);

// yequals(Label("$L$",0,up),L,extend=true,blue);
// yequals(Label("$L+\epsilon$",1,NW),L+epsilon,extend=true,red+dashed);
// yequals(Label("$L-\epsilon$",1,SW),L-epsilon,extend=true,red+dashed);

// xequals(N,extend=true,darkgreen+dashed);
// labelx(shift(0,-10)*"$N=\frac{1}{\epsilon}$",N,E,darkgreen);

// label("$a_n=1+\frac{1}{n},\quad \epsilon=\frac{1}{4}$",point((0,1)),10S+E);




// Example 03:xsitch
// pair c=(0,0.8);
// int iters(pair z, int max=160) {
//     int n=0;
//     while(abs(z) < 2 && n < max) {
//         z=z*z+c;
//         ++n;
//     }
//     return n;
// }
// int[] cutoffs={12,15,20,30,40,60,200};
// int key(pair z) {
// int i=iters(z);
// int j=0;
// while(cutoffs[j] < i)
//     ++j;
//     return j;
// }
// int width=210;
// int height=190;
// real zoom=2.5/200;
// int[][] values=new int[width][height];
// int[] histogram;  for(int v=0; v < 10; ++v) histogram.push(0);
// for(int i=0; i < width; ++i) {
//     real x=zoom*(i-width/2);
//     for(int j=0; j < height; ++j) {
//         real y=zoom*(j-height/2);
//         int v=key((x,y));
//         values[i][j]=v;
//         ++histogram[v];
//     }
// }
// // Print out a histogram.
// write("histogram: ");
// write(histogram);
// pen linepen(int i, int max) {
//     real w=i == -1 || i == max+1   ? 2.0 :
//         i % 10 == 0 || i == max ? 1.0 :
//         i % 5 == 0              ? 0.8 :
//         0.25;
//     return linewidth(w);
// }
// pen xpen(int i) {
// return linepen(i,width)+(i == width/2 ? red :
//     i == 75 || i == width-75 ? dashed :
//     black);
// }
// pen ypen(int i) {
// return linepen(i,height)+(i == height/2 ? red :
//     i == 75 || i == height-75 ? dashed :
//     black);
// }
// // The length of the side of a cross stitch cell.
// real cell=2.3mm;
// transform t=scale(cell);
// picture tick;
// draw(tick,(0,0)--(1,1));

// picture ell;
// draw(ell,(0,1)--(0,0)--(0.7,0));

// picture cross;
// draw(cross,(0,0)--(1,1));
// draw(cross,(1,0)--(0,1));

// picture star;
// draw(star,(0.15,0.15)--(0.85,0.85));
// draw(star,(0.85,0.15)--(0.15,0.85));
// draw(star,(.5,0)--(.5,1));
// draw(star,(0,.5)--(1,.5));

// picture triangle;
// draw(triangle,(0,0)--(2,0)--(1,1.5)--cycle);

// picture circle;
// fill(circle,shift(1,1)*unitcircle);

// picture ocircle;
// draw(ocircle,shift(1,1)*unitcircle);

// picture spare;
// fill(spare,(0,0)--(1,1)--(0,1)--cycle);

// picture[] pics={tick,ell,cross,star,triangle,circle};
// pen[] colors={
//     black,0.2purple,0.4purple,0.6purple,
//     0.8purple,purple,0.8purple+0.2white};

// frame[] icons;
// icons.push(newframe);
// for(picture pic : pics) {
//     // Scaling factor, so that we don't need weird line widths.
//     real X=1.0;
//     frame f=pic.fit(.8X*cell,.8X*cell,Aspect);
//     f=scale(1/X)*f;
//     // Center the icon in the cell.
//     f=shift((cell/2,cell/2)-0.5(max(f)-min(f)))*f;
//     icons.push(f);
// }

// void drawSection(int xmin, int xmax, int ymin, int ymax) {
//     static int shipoutNumber=0;

//     // Draw directly to a frame for speed reasons.
//     frame pic;

//     for(int i=xmin; i <= xmax; ++i) {
//         draw(pic,t*((i,ymin)--(i,ymax)),xpen(i));
//         if(i%10 == 0) {
//             label(pic,string(i),t*(i,ymin),align=S);
//             label(pic,string(i),t*(i,ymax),align=N);
//         }
//     }
//     for(int j=ymin; j <= ymax; ++j) {
//         draw(pic,t*((xmin,j)--(xmax,j)),ypen(j));
//         if(j%10 == 0) {
//             label(pic,string(j),t*(xmin,j),align=W);
//             label(pic,string(j),t*(xmax,j),align=E);
//         }
//     }

//     if(xmin < 0)
//         xmin=0;
//     if(xmax >= width)
//         xmax=width-1;
//     if(ymin < 0)
//         ymin=0;
//     if(ymax >= height)
//         ymax=height-1;

//     int stitchCount=0;
//     path box=scale(cell) *((0,0)--(1,0)--(1,1)--(0,1)--cycle);
//     for(int i=xmin; i < xmax; ++i)
//         for(int j=ymin; j < ymax; ++j) {
//         int v=values[i][j];
//         add(pic,icons[v],(i*cell,j*cell));
//         //fill(pic,shift(i*cell,j*cell)*box,colors[v]);
//         if(v != 0)
//             ++stitchCount;
//     }

//     write("stitch count: ",stitchCount);

//     //  shipout("xstitch"+string(shipoutNumber),pic);
//     shipout(pic);
//     ++shipoutNumber;
// }
// //drawSection(-1,width+1,-1,height+1);

// //drawSection(-1,80,height-80,height+1);
// //drawSection(70,150,height-80,height+1);
// drawSection(quotient(width,2)-40,quotient(width,2)+40,quotient(height,2)-40,quotient(height,2)+40);
// //drawSection(width-150,width-70,-1,80);
// //drawSection(width-80,width+1,-1,80);



// Example 05:xsinx
import graph;
size(300,0);

real f(real x) {return (x != 0.0) ? x * sin(1.0 / x) : 0.0;}
pair F(real x) {return (x,f(x));}

xaxis("$x$",red);
yaxis(red);
draw(graph(f,-1.2/pi,1.2/pi,1000));
label("$x\sin\frac{1}{x}$",F(1.1/pi),NW);

picture pic;
size(pic,50,IgnoreAspect);
xaxis(pic,red);
yaxis(pic,red);
draw(pic,graph(pic,f,-0.1/pi,0.1/pi,1000));

add(new void(frame f, transform t) {
    frame G=shift(point(f,N+0.85W))*align(bbox(pic,blue),10SE);
    add(f,G);
    draw(f,t*box(min(pic,user=true),max(pic,user=true)),blue);
    draw(f,point(G,E)--t*point(pic,W),blue);
});