 /* Geogebra to Asymptote conversion, documentation at artofproblemsolving.com/Wiki go to User:Azjps/geogebra */
import graph; size(13.42707685922653cm); 
real labelscalefactor = 0.5; /* changes label-to-point distance */
pen dps = linewidth(0.7) + fontsize(10); defaultpen(dps); /* default pen style */ 
pen dotstyle = black; /* point style */ 
real xmin = -6.663464185902662, xmax = 6.763612673323867, ymin = -7.976868935666972, ymax = 5.4502079235595575;  /* image dimensions */
pen svsvsv = rgb(0.1450980392156863,0.1450980392156863,0.1450980392156863); 
Label laxis; laxis.p = fontsize(10); 
xaxis(xmin, xmax,defaultpen+svsvsv, Ticks(laxis, Step = 1., Size = 2, NoZero),EndArrow(6), above = true); 
yaxis(ymin, ymax,defaultpen+svsvsv, Ticks(laxis, Step = 1., Size = 2, NoZero),EndArrow(6), above = true); /* draws axes; NoZero hides '0' label */ 
 /* draw figures */
 /* dots and labels */
clip((xmin,ymin)--(xmin,ymax)--(xmax,ymax)--(xmax,ymin)--cycle); 
 /* end of picture */