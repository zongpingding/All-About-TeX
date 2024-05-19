//macros de geometrie dans l'espace par D. Comin, version du 31/01/09.

import math;
import three;
import markers;
import geometry;
import solids;
import labelpath;
import bsp;
settings.render=0;
settings.prc=false;
real croix=0.03;
currentlight=nolight;
bool pointilles=true;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Cette proc茅dure a 茅t茅 茅crite par Philippe Ivaldi, elle permet la gestion des faces et ar锚tes cach茅es.                                                                                                           //
// Je ne suis que le "ravaleur besogneux du talent des autres" ...                                                                                                                                                                           //
                                                                                                         //
face[] hidden, visible;                                                                                  //
typedef path3[] shape;                                                                                   //
                                                                                                         //
                                                                                                         //
void addshapes(face[] F, shape[] shp, pen drawpen=currentpen, pen fillpen=white)
{
  for(int i=0; i < shp.length; ++i)
    for(int j=0; j < shp[i].length; ++j) {
      path3 g=shp[i][j];
      picture pic=F.push(g);
      if(fillpen != nullpen) filldraw(pic,project(g),fillpen, drawpen);
      else draw(pic,project(g),drawpen);
      // filldraw(pic,g,currentlight.intensity(F[F.length-1].point)*fillpen, drawpen);
    }
}
                                                                                           
                                                                                                         
// trace les faces de la scene enti猫re                                                                                                                                                                                                                         //                  
void trace(){                                                                                            
add(hidden);  
if (pointilles==true){                                                                                   //
add(visible);                                                                                            //
					}
}                                                                                                        //
///////////////////////////////////////////////////////////////////////////////////////////////////////////




//d茅finit les directions
pair nord,sud,est,ouest,nouest,nest,souest,sest;
nord=(0,1);
sud=(0,-1);
est=(1,0);
ouest=(-1,0);
nouest=(-1,1);
nest=(1,1);
souest=(-1,-1);
sest=(1,-1);
//trace le point (la croix) plac茅 en A
void pointe(triple A, pen sty=currentpen){
triple v=invert((croix,croix),currentprojection.camera,currentprojection.target);
triple u=invert((-croix,croix),currentprojection.camera,currentprojection.target);
draw(project(A-v)--project(A+v),p=sty);
draw(project(A-u)--project(A+u),p=sty);
}

//nomme et trace le point (la croix) plac茅 en A
void nomme(picture pic=currentpicture, Label L, triple position,pair direction=sud, pen p=currentpen, filltype filltype=NoFill){
pointe(position,p);
label(L, project(position)+croix*direction,direction,p);
}

// insert le solide sous forme shape dans la scene pour 锚tre trac茅 脿 la fin
void insertscene(shape shp,pen remplissage=white,pen aretes=black){
shape[] group={shp};
//addshapes(hidden, group, drawpen=aretes+linewidth(bp),fillpen=remplissage);
addshapes(hidden, group, drawpen=aretes,fillpen=remplissage);
if (pointilles==true){
addshapes(visible, group, drawpen=aretes+linetype("6 18"), fillpen=nullpen);
					}
}
//
//aretes+dotted

//elimine les sommets redondants
triple[] elimine(triple[] som){
for(int i=0;i<som.length-1;i=i+1){
for(int j=i+1;j<som.length;j=j+1){
if(som[i]==som[j]){som.delete(j);j=j-1;};
}
}
return som;
}
//renvoie les sommets d'un polyedre
triple[] sommet(shape faces){
triple[] som;
for(int i=0;i<faces.length;i=i+1){
for(int j=0;j<length(faces[i]);j=j+1){
som.push(point(faces[i],j));
};
}
som=elimine(som);
return som;
}

// nomme les sommets d'un polyedre ou une liste de sommets
void nomme(shape solide, pair direction=sud ...string[] txt){
triple[] M=elimine(sommet(solide));
for(int i=0;i<txt.length;i=i+1){
label(txt[i],project(M[i]),direction);
}
}
void nomme(triple[] M, pair direction=sud ...string[] txt){
for(int i=0;i<txt.length;i=i+1){
label(txt[i],project(M[i]),direction);
}
}

//trace un pav茅 de sommet 脿 partir du point A et de dimensions L*l*h
//renvoie les sommets du pav茅.
triple[] pave(triple A,real L, real p,real h,pen remplissage=white,pen aretes=black){
triple[] som;
som[0]=A;
som[1]=A+(0,0,h);
som[2]=A+(0,L,h);
som[3]=A+(0,L,0);
som[4]=som[3]+(p,0,0);
som[5]=som[2]+(p,0,0);
som[6]=som[1]+(p,0,0);
som[7]=som[0]+(p,0,0);
shape f;
f[0]=som[0]--som[3]--som[4]--som[7]--cycle;
f[1]=som[0]--som[1]--som[2]--som[3]--cycle;
f[4]=som[0]--som[7]--som[6]--som[1]--cycle;
f[2]=shift(0,L,0)*f[4];
f[3]=shift(p,0,0)*f[1];
f[5]=shift(0,0,h)*f[0];
insertscene(f,remplissage,aretes);
return som;}

//trace une pyramide de sommet S et de base le path3 B
//renvoie les sommets
triple[] pyramide(triple S, path3 B, pen remplissage=white,pen aretes=black){
triple[] som;
som[0]=S;
for(int i=0;i<length(B);i=i+1){
som[1+i]=point(B,i);}
shape f;
f[0]=B;
for(int i=0;i<length(B)-1;i=i+1){
f[i+1]=S--som[1+i]--som[2+i]--cycle;
}
f[length(B)]=S--som[1]--som[length(B)]--cycle;
insertscene(f,remplissage,aretes);
return som;}

//trace un prisme de base ABCDE et de hauteur h
//renvoie les sommets du prisme.
triple[] prisme(real h, path3 B, pen remplissage=white,pen aretes=black){
triple[] som;
for(int i=0;i<length(B);i=i+1){
som[i]=point(B,i);}
for(int i=0;i<length(B);i=i+1){
som[i+length(B)]=shift(unit(normal(B))*h)*point(B,i);}

shape f;
f[0]=B;
f[length(B)+1]=shift(unit(normal(B))*h)*B;
for(int i=0;i<length(B)-1;i=i+1){
f[i+1]=som[i]--som[1+i]--som[1+i+length(B)]--som[i+length(B)]--cycle;
}
f[length(B)]=som[length(B)-1]--som[0]--som[length(B)]--som[2*length(B)-1]--cycle;
insertscene(f,remplissage,aretes);
return som;}




//place le texte txt le long de AB
void etiquette(triple C, triple D, string txt,bool dessus=true,pen sty=currentpen){
pair A=project(C);
pair B=project(D);
if (dessus==true){
label(rotate(degrees(B-A))*txt,0.5*B+0.5*A,dir(degrees(B-A)+90),sty);
} else {
label(rotate(degrees(B-A))*txt,0.5*B+0.5*A,dir(degrees(B-A)-90),sty);
}
}

//trace une fl猫che de cotation de A 脿 B 脿 d mm audessus du segment avec le texte.
void cote(triple A1,triple B1, string texte, real d,bool trait=false,pen sty=black){
pair M,N;
pair A=project(A1);
pair B=project(B1);
M=A+d/10*dir(degrees(B-A)+90);
N=B+d/10*dir(degrees(B-A)+90);
label(rotate(degrees(N-M))*texte,0.5*N+0.5*M,dir(degrees(N-M)+90),sty);
draw(B+d/10*dir(degrees(B-A)+90)--A+d/10*dir(degrees(B-A)+90),Arrows,p=sty);
if(trait==true){
draw(A--A+d/10*dir(degrees(B-A)+90),sty+0.1);
draw(B--B+d/10*dir(degrees(B-A)+90),sty+0.1);
}
}

//retourne un point sur un chemin avec le param猫tre r entre 0 et 1
triple pointsur(path3 chemin, real r)
{
 return point(chemin,arctime(chemin,r*arclength(chemin)));
}

//retourne le milieu de [A,B].
triple milieu(triple A, triple B){
return 0.5(A+B);
} 
//code le milieu du segment [A,B] 
void codemilieu(triple A1, triple B1, int trait){
pair M=project(milieu(A1,B1));
pair A=project(A1);
pair B=project(B1);
if(trait < 4)  { 
draw(A--M,invisible,StickIntervalMarker(1,n=trait,angle=-30,size=3mm,space=1mm));
draw(M--B,invisible,StickIntervalMarker(1,n=trait,angle=-30,size=3mm,space=1mm));
}
else {if(trait ==4) { 
draw(A--M,invisible,TildeIntervalMarker(i=1,size=3mm));
draw(M--B,invisible,TildeIntervalMarker(i=1,size=3mm));
}else {
draw(A--M,invisible,CircleBarIntervalMarker(1,n=0));
draw(M--B,invisible,CircleBarIntervalMarker(1,n=0));
}
}
}

//code les segments d茅finis par le tableau triple[] K={A,B,C,...} avec trait traits
void code(pen sty=invisible,int trait ... triple[] Som){
pair[] K;
for(int i=0;i<Som.length;i=i+1){
K[i]=project(Som[i]);
}
if(trait < 4) {
for(int i=0; i <=(K.length-2); i=i+2) { draw(K[i]--K[i+1],sty,StickIntervalMarker(1,n=trait,angle=-30,size=3mm,space=1mm));}
}else {if(trait ==4) {
for(int i=0; i <=(K.length-2); i=i+2) { draw(K[i]--K[i+1],sty,TildeIntervalMarker(i=1,size=3mm));}
}else {for(int i=0; i <=(K.length-2); ++i) {draw(K[i]--K[i+1],sty,CircleBarIntervalMarker(1,n=0));}
}
}
}

//code les angles avec des traits
void codeangle(triple D,triple A, triple E,string txt="", int trait,pen remplissage=invisible,pen sty=currentpen,real r=0.5 ){
real ang=aCos(dot(D-A,E-A)/(abs(D-A)*abs(E-A)));
path3 a=arc(A,r*unit(D-A)+A,r*unit(E-A)+A,cross(D-A,E-A));
filldraw(project(A--a--cycle),remplissage,sty);
triple m = rotate(ang/2,A,A+cross(D-A,E-A))*(A+unit(D-A)*r);
triple p = rotate(ang/2+4,A,A+cross(D-A,E-A))*(A+unit(D-A)*r);
triple n = rotate(ang/2-4,A,A+cross(D-A,E-A))*(A+unit(D-A)*r);
if(trait==1){
		draw(project(m-unit(m-A)*croix--m+unit(m-A)*croix));
		} else{
if(trait==2){
		draw(project(m-unit(m-A)*croix--m+unit(m-A)*croix));
		draw(project(n-unit(n-A)*croix--n+unit(n-A)*croix));
		} else{
if(trait==3){
		draw(project(m-unit(m-A)*croix--m+unit(m-A)*croix));
		draw(project(n-unit(n-A)*croix--n+unit(n-A)*croix));
		draw(project(p-unit(p-A)*croix--p+unit(p-A)*croix));
		} else {
		draw(project(circle(m,croix,cross(D-A,E-A))));	
		}
}
}
label(txt,project(rotate(ang/2-2,A,A+cross(D-A,E-A))*(A+unit(D-A)*(r+3croix))),E+D-2A);
}

//code les angles droits
void angledroit(triple A,triple B, triple C,real taille=0.2, pen p=black){
triple u,v;
u=unit(C-B);
v=unit(A-B);
draw(project(B)+project(taille*v)--project(B)+project(taille*(u+v))--project(B)+project(taille*u),p);
}

//trace un path3 ouvert visible sur la scene finale sans tenir compte des parties cach茅es ... utile ? ...
void tracepath3(path3 p, pen sty=currentpen){
for(int i=0;i<=100;i=i+1){
draw(project(pointsur(p,i/100))--project(pointsur(p,(i+1)/100)),sty);
}
}

// renvoie un cercle de centre O et passant par A et de vecteur normal n.
path3 cercle(triple O, triple A, triple n){
return circle(O,abs(A-O),n);
}
// renvoie un cercle de centre O et de rayon R de vecteur normal n.
path3 cercleR(triple O, real R, triple n){
return circle(O,R,n);
}

//retourne le segment [AB] qui peut d茅passer de a unit茅s.
path3 segment(triple A, triple B,real a=0,pen sty=currentpen){
path3 segment;
segment=a*unit(A-B)+A--B+a*unit(B-A);
return segment;
}

//renvoie le projet茅 de M orthogonal sur le plan passant par A,B et C
triple projortho(triple M, triple A, triple B, triple C){
triple N,n,H;
real a;
n=cross(B-A,C-A);
a=dot(n,A-M)/abs(n)^2;
H=a*n+M;
return H;
}

//renvoie l'intersection de de (MN) avec le plan passant par A,B et C
triple intersectionDP(triple M,triple N, triple A, triple B, triple C){
triple n,d,I;
real a;
n=cross(B-A,C-A);
d=N-M;
a=dot(n,A-M)/dot(n,d);
I=a*d+M;
return I;
}

//retourne un point sur un chemin avec le param猫tre r entre 0 et 1
triple pointsur(path3 chemin, real r)
{
 return point(chemin,arctime(chemin,r*arclength(chemin)));
}

//renvoie l'intersection de (MN) avec (AB)
triple intersectionDD(triple M,triple N, triple A, triple B){
triple n,d,I;
real a;
n=cross(B-A,N-A);
a=dot(n,M-B);
if(a==0){
I=intersectionDP(M,N,A,B,B+n);}
return I;
}

//renvoie l'isobarycentre d'une face
triple iso(path3 face){
triple som=(0,0,0);
for(int i=0;i<length(face);i=i+1){
som=som+point(face,i);
}
return som/length(face);
}

//renvoie le cone de revolution de base le disque de centre C et de rayon "rayon" et de "hauteur" cm
revolution conerevolution(triple C, real rayon, real hauteur,real section=1,triple axe=Z){
revolution Cone;
path3 gene=rayon*Y--(1-section)*rayon*Y+section*hauteur*Z;
if(axe==Z){Cone=shift(C)*revolution(gene,Z);} else{
triple u=cross(Z,axe);
Cone=shift(C)*rotate(aCos(dot(Z,axe)/abs(axe)),u)*revolution(gene,Z);}
return Cone;
}

//renvoie et trace la section plane d'un solide de r茅volution 脿 une hauteur h entre 0 et 1.
path3 sectionplane(revolution r,real section, pen p=currentpen){
skeleton s;
//real t=aCos(1-2*section)/180;
//r.transverse(s,reltime(r.g,t));
r.transverse(s,reltime(r.g,section));
//r.longitudinal(s);
draw(s.transverse.back,p+dashed);
draw(s.transverse.front,p);
path3 sect;
for(int i=0;i<s.transverse.back.length;i=i+1){sect=sect..s.transverse.back[i];}
for(int i=0;i<s.transverse.front.length;i=i+1){sect=sect..s.transverse.front[i];}
return sect; 
}

// d茅finit et trace une sphere/calotte spherique comme solide de revolution. k et h doivent etre entre 0 et 1, ils d茅finissent respectivement le debut et la fin de la calotte : 0 correspond au pole sud et 1 au nord de la sphere associ茅e.
revolution sphere(triple c=O, real rayon,real k=0,real h, int n=32){
real x(real t){return cos(t);};
real y(real t){return 0;};
real z(real t){return sin(t);};
real a = asin(2k-1);
real b = asin(2h-1);
path3 p =graph(x,y,z,a,b);
revolution calotte=revolution((0,0,0),p,Z);
return shift(c)*scale3(rayon)*calotte;
}

void trace(picture pic=currentpicture, Label L="", path3 g,
align alignt=NoAlign, pen p=currentpen,
arrowbar fleche=None, arrowbar barre=None, margin marge=NoMargin,
Label legende="", marker mark=nomarker){
draw(pic,L,project(g),alignt,p,fleche,barre,marge,legende,mark);
}

void label(string txt, triple M, pair alignt, pen p=currentpen){
label(txt, project(M),alignt,p);
}