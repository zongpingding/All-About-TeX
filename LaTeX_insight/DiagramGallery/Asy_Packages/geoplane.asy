// Auteur D. Comin, 20 mars 2009.
// Ce fichier est distribu茅 sous licence GNU-GPL, je ne sais pas exactement ce que 莽a veut dire mais je trouve que 莽a a de la gueule. 
import math;
import markers;
import geometry;
import patterns;
import labelpath;

//d茅finit le type repere
struct repere {
pair origine ;
pair abscisse;
pair ordonnee;
string originetxt ;
string abscissetxt;
string ordonneetxt;
}

//D茅finitions des constantes 
unitsize(1cm);
real croix;
pair basdroit,basgauche,hautdroit,hautgauche;
path cadre;
croix=0.08;
bool mainlevee=false;
srand(seconds(time("%a %b %d %H:%M:%S %Z %Y")));
repere canonique;
canonique.origine=(0,0);
canonique.abscisse=(1,0);
canonique.ordonnee=(0,1);
canonique.originetxt="$O$";
canonique.abscissetxt="$\vec{i}$";
canonique.ordonneetxt="$\vec{j}$";
repere reperecourant=canonique;

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
//defaultpen();
//trace un cadre, invisible par defaut
void figure(pair A,pair B, pen p=invisible){
draw(A--(xpart(B),ypart(A))--B--(xpart(A),ypart(B))--cycle,p);
basgauche=A;
basdroit=(xpart(B),ypart(A));
hautdroit=B;
hautgauche=(xpart(A),ypart(B));
cadre=A--(xpart(B),ypart(A))--B--(xpart(A),ypart(B))--cycle;

}

// trace des fractions 脿 partir d'un quadrillage, etc 
void fractionRect(int l,int h, int n=0, pen remplissage=grey, pen trait=currentpen){
int k=1;
for(int j=1;j<=h;j=j+1){
	for(int i=1;i<=l;i=i+1){
	if(k<=n){filldraw(shift(basgauche)*shift((i-1)*abs(hautgauche-hautdroit)/l,(j-1)*abs(hautgauche-basgauche)/h)*xscale(abs(hautgauche-hautdroit)/l)*yscale(abs(hautgauche-basgauche)/h)*unitsquare,remplissage,trait);} else
	{draw(shift(basgauche)*shift((i-1)*abs(hautgauche-hautdroit)/l,(j-1)*abs(hautgauche-basgauche)/h)*xscale(abs(hautgauche-hautdroit)/l)*yscale(abs(hautgauche-basgauche)/h)*unitsquare,trait);}	
k=k+1;	}
}
}

void fractionCercle(int l,int n=0, pen remplissage=grey, pen trait=currentpen){
int k=1;
real r=max(abs(hautgauche-hautdroit)*0.5,abs(hautgauche-basgauche)*0.5);
pair c=0.5(hautgauche+basdroit);
for(int i=0;i<l;i=i+1){
			if(k<=n){filldraw(c--arc(c,r,360*i/l,360*(i+1)/l)--cycle,remplissage,trait);} else 
			{draw(c--arc(c,r,360*i/l,360*(i+1)/l)--cycle,trait);}
		k=k+1;}
}

void fractionPoly(int l,int n=0, pen remplissage=grey, pen trait=currentpen){
int k=1;
real r=min(abs(hautgauche-hautdroit)*0.5,abs(hautgauche-basgauche)*0.5);
pair c=0.5(hautgauche+basdroit);
for(int i=0;i<l;i=i+1){
			if(k<=n){filldraw(c--c+r*(Cos(360*i/l),Sin(360*i/l))--c+r*(Cos(360*(i+1)/l),Sin(360*(i+1)/l))--cycle,remplissage,trait);} else 
			{draw(c--c+r*(Cos(360*i/l),Sin(360*i/l))--c+r*(Cos(360*(i+1)/l),Sin(360*(i+1)/l))--cycle,trait);}
		k=k+1;}
}


// nombre al茅atoire entre -a et a
real eps(){
real x=rand()/randMax;
//return a-2*x*a;
if(x<=1/6){return 5;}else{
if(x<=1/3){return 6;}else{
if(x<=1/2){return 7;}else{
if(x<=2/3){return -5;}else{
if(x<=5/6){return -6;}else{return -7;};
};
};
};
};
}


//trace le point (la croix) plac茅 en A
void pointe(pair A,pen sty=currentpen){
draw(A-(croix,croix)--A+(croix,croix),p=sty);
draw(A+(-croix,croix)--A+(croix,-croix),p=sty);
}
//nomme et trace le point (la croix) plac茅 en A
//void nomme(picture pic=currentpicture, Label L, pair position,align align=NoAlign, pen p=currentpen, filltype //filltype=NoFill){
//draw(position-(croix,croix)--position+(croix,croix),p);
//draw(position+(-croix,croix)--position+(croix,-croix),p);
//label(pic, L,  position,align,p,filltype);
//}
void nomme(Label L, pair A,pair direction , pen p=currentpen){
draw(A-(croix,croix)--A+(croix,croix),p);
draw(A+(-croix,croix)--A+(croix,-croix),p);
label(L, A+0.05*unit(direction),direction,p);
}

//retourne le point placer 脿 distance cm de A et faisant un angle de angle degre avec l'horizontale
pair pointdistant(pair A,real distance, real angle){
pair B ;
B=A+distance*dir(angle);
return B;
}
// retourne le point M 脿 l cm de O et tel que angle MOA=a, ds le sens trigo
pair point_angle_dist(pair O, pair A, real a, real l){
pair M;
M=l*dir(a+degrees(A-O))+O;
return M;
}
//retourne le point placer 脿 a cm de A et b cm de B
pair compas(pair A, pair B, real a, real b){
pair C;
real c;
real angle;
c=abs(B-A);
angle=(acos((a^2+c^2-b^2)/(2*a*c))+angle(B-A))/pi*180;
C=pointdistant(A,a,angle);
return C;
}
//retourne un point sur un chemin avec le param猫tre r entre 0 et 1
pair pointsur(path chemin, real r)
{
 return point(chemin,arctime(chemin,r*arclength(chemin)));
}

// nomme les objets "path"
void nomchemin(string txt,path chemin, real pos=0.9, pair direction, pen p=currentpen){
label(txt,pointsur(chemin,pos),direction,p);
}

//retourne le milieu de [A,B].
pair milieu(pair A, pair B){
return pointsur(A--B,0.5);
} 

//trace une fl猫che de cotation de A 脿 B 脿 d mm audessus du segment avec le texte au milieu.
void cotemilieu(pair A,pair B, string texte, real d,bool trait=false,pen sty=black){
draw(Label(texte,align=Center,Rotate(-dir(B--A)),filltype=UnFill),B+d/10*dir(degrees(B-A)+90)--A+d/10*dir(degrees(B-A)+90),Arrows(1.5mm),p=sty);
if(trait==true){
draw(A--A+d/10*dir(degrees(B-A)+90),sty+0.1);
draw(B--B+d/10*dir(degrees(B-A)+90),sty+0.1);
}
} 
//place txt le long de AB
void etiquette(pair A, pair B, string txt,bool dessus=true,pen sty=currentpen){
if (dessus==true){
label(rotate(degrees(B-A))*txt,0.5*B+0.5*A,dir(degrees(B-A)+90),sty);
} else {
label(rotate(degrees(B-A))*txt,0.5*B+0.5*A,dir(degrees(B-A)-90),sty);
}
}

//trace une fl猫che de cotation de A 脿 B 脿 d mm audessus du segment avec le texte au dessus.
void cote(pair A,pair B, string texte, real d,bool trait=false,pen sty=black){
pair M,N;
M=A+d/10*dir(degrees(B-A)+90);
N=B+d/10*dir(degrees(B-A)+90);
label(rotate(degrees(N-M))*texte,0.5*M+0.5*N,dir(degrees(M-N)-sgn(d)*90),sty);
draw(B+d/10*dir(degrees(B-A)+90)--A+d/10*dir(degrees(B-A)+90),Arrows(1.5mm),p=sty);
if(trait==true){
draw(A--A+d/10*dir(degrees(B-A)+90),sty+0.1);
draw(B--B+d/10*dir(degrees(B-A)+90),sty+0.1);
}
}

//remplis avec des hachures espac茅es de espace mm, avec un angle de angle 掳 le chemin ferm茅 p 
void hachurage(path p,real  espace, real angle, pen pen=currentpen){
add("hachure",hatch(espace,dir(angle),pen));
fill(p,pattern("hachure"));
}

//code les segments d茅finis par le tableau pair[] K={A,B,C,...} avec trait traits
void code(pen sty=invisible,int trait ... pair[] K){
if(trait < 4) {
for(int i=0; i <=(K.length-2); i=i+2) { draw(K[i]--K[i+1],sty,StickIntervalMarker(1,n=trait,angle=-30,size=3mm,space=1mm));}
}else {if(trait ==4) {
for(int i=0; i <=(K.length-2); i=i+2) { draw(K[i]--K[i+1],sty,TildeIntervalMarker(i=1,size=3mm));}
}else {for(int i=0; i <=(K.length-2); i=i+2) {draw(K[i]--K[i+1],sty,CircleBarIntervalMarker(1,n=0));}
}
}
if(trait==6){
for(int i=0; i <=(K.length-2); i=i+2) { draw(K[i]--K[i+1],sty,CrossIntervalMarker(1,4));}}
}
//code le milieu du segment [A,B]
void codemilieu(pen sty=invisible,pair A, pair B, int trait){
if(trait < 4)  { 
draw(A--milieu(A,B),sty,StickIntervalMarker(1,n=trait,angle=-30,size=3mm,space=1mm));
draw(milieu(A,B)--B,sty,StickIntervalMarker(1,n=trait,angle=-30,size=3mm,space=1mm));
}
else {if(trait ==4) { 
draw(A--milieu(A,B),sty,TildeIntervalMarker(i=1,size=3mm));
draw(milieu(A,B)--B,sty,TildeIntervalMarker(i=1,size=3mm));
}else {
draw(A--milieu(A,B),sty,CircleBarIntervalMarker(1,n=0));
draw(milieu(A,B)--B,sty,CircleBarIntervalMarker(1,n=0));

}
}
}


// code les longueurs avec un arc de A 脿 B.
void cotearc(pair A, pair B, string txt="", real dir=30,pen sty=currentpen){
path a = A{dir(degrees(B-A)+dir)}..{dir(degrees(B-A)-dir)}B;

if (dir > 0 ){
	
	draw(Label(txt,align=Center,Rotate(-dir(B--A)),filltype=UnFill),a,p=sty);
		} else {
	draw(Label(txt,align=Center,Rotate(dir(B--A)),filltype=UnFill),a,p=sty);	
			};
}
// code les secteurs angulaires
void codesecteur(pair A, pair B, pair C, real r=1, pen sty=grey){
filldraw(B--(B+r*unit(A-B))--arc(B,z1=B+r*unit(A-B),z2=B+r*unit(C-B))--cycle,sty,invisible);
}

//code les angles avec des traits et un nombre nbarc d'arcs
void codeangle(pair A,pair B, pair C,string txt="", int trait,int nbarc=1,pen sty=currentpen,real rayon=10mm ){
markangle(txt,n=nbarc,A,B,C,radius=rayon,marker(markinterval(stickframe(n=trait,p=sty),true)),p=sty);
}
//code les angles droits
void angledroit(pair A,pair B, pair C,real taille=0.3, pen p=black){
pair u,v;
u=unit(C-B);
v=unit(A-B);

draw(B+taille*v--B+taille*(u+v)--B+taille*u,p);

}
//trace des droites gradu茅es pour les in茅quations
void inequation(string txt="", real valeur, real crochet, real zone,pen pen=currentpen){
real h;
h=0.1;
draw(0.5*(basgauche+hautgauche)--0.5*(basdroit+hautdroit),Arrow(2mm));
draw((0,-h)--(0,h),linewidth(1.2bp));
label("0",(0,-h),S);
draw((1,-h)--(1,h),linewidth(1.2bp));
label("1",(1,-h),S);
label(txt,(valeur,-h-0.2),S);
draw((valeur+crochet*0.2,0.3)--(valeur,0.3)--(valeur,-0.3)--(valeur+crochet*0.2,-0.3),linewidth(2bp));
add("hachure",hatch(1.5mm,NE,black));
if(zone==-1){
fill(0.5*(basgauche+hautgauche)+(0,0.2)--valeur+(0,0.2)--valeur+(0,-0.2)--0.5*(basgauche+hautgauche)+(0,-0.2)--cycle,pattern("hachure"));
} else { 
fill(0.5*(basdroit+hautdroit)+(0,0.2)--valeur+(0,0.2)--valeur+(0,-0.2)--0.5*(basdroit+hautdroit)+(0,-0.2)--cycle,pattern("hachure"));
}
}

// renvoie des segments dans le style "脿 main lev茅e"
path segmentML(pair A, pair B,real a=0){
real alpha,beta;
pair M,N;
M=A+(B-A)/3;
N=A+(B-A)*2/3;
//alpha=6*sin(degrees(A-B))-3;
alpha=eps();
beta=eps();
//beta=6*sin(length(A--B)*50)-3;
return a*unit(A-B)+A..A{dir(degrees(B-A)+alpha)}..{dir(degrees(M-A)+eps())}M{dir(degrees(M-A)+eps())}..{dir(degrees(N-M)+eps())}N{dir(degrees(N-M)+eps())}..{dir(degrees(B-N)+beta)}B..a*unit(B-A)+B;
}

//retourne le segment [AB] qui peut d茅passer de a cm
path segment(pair A, pair B,real a=0){
path segment;
if (mainlevee==false){segment=a*unit(A-B)+A--B+a*unit(B-A);} else {segment=segmentML(A,B,a);};
return segment;
}


//renvoie un polygone d茅finit par une matrice pair[]
path polygone(... pair[] K){
path p;
K.push(K[0]);
for(int i=0;i<K.length-1;i=i+1){p=p..segment(K[i],K[i+1]);}
p=p--cycle;
//if(mainlevee==true){
//p=p..{dir(degrees(K[0]-K[K.length-1])+eps())}cycle;} else{
//p=p--cycle;
//};
return p;
}

//renvoie la demi-droite d'origine A passant par B
path demidroite(pair A, pair B){
pair s,u;
path ligne;
pair[] dte;
path droite;
pair C;
if(xpart(A)==xpart(B)){
s=(ypart(hautgauche)-ypart(B))/(ypart(A)-ypart(B));
u=(ypart(basgauche)-ypart(B))/(ypart(A)-ypart(B));
}
else{
s=(xpart(basdroit)-xpart(B))/(xpart(A)-xpart(B));
u=(xpart(basgauche)-xpart(B))/(xpart(A)-xpart(B));
}
ligne=s*A+(1-s)*B--u*A+(1-u)*B;
dte=intersectionpoints(ligne,cadre);
if(dot(B-A,dte[1]-dte[0])<0){C=dte[0];} else {C=dte[1];};

if(mainlevee==false){droite=C--A;} else {droite=segmentML(A,B)..segmentML(B,C);};
return droite;
}

//retourne une droite passant par A et B
path droite(pair A, pair B){
pair s,u;
path ligne;
pair[] dte;
path droite;
if(xpart(A)==xpart(B)){
s=(ypart(hautgauche)-ypart(B))/(ypart(A)-ypart(B));
u=(ypart(basgauche)-ypart(B))/(ypart(A)-ypart(B));
}
else{
s=(xpart(basdroit)-xpart(B))/(xpart(A)-xpart(B));
u=(xpart(basgauche)-xpart(B))/(xpart(A)-xpart(B));
}
ligne=s*A+(1-s)*B--u*A+(1-u)*B;
dte=intersectionpoints(ligne,cadre);
if(mainlevee==false){droite=dte[0]--dte[1];} else {
if(dot(B-A,dte[1]-dte[0])<0){droite=segmentML(dte[0],B)..segmentML(B,A)..segmentML(A,dte[1]);} else {droite=segmentML(dte[0],A)..segmentML(A,B)..segmentML(B,dte[1]);};
};
return droite;
}
//retourne une droite, la perpendiculaire 脿 (AB) passant par M
path perpendiculaire(pair A, pair B, pair M){
pair N;
path dte;
N=M+dir(degrees(B-A)+90);
dte=droite(M,N);
return dte;
}
//retourne une droite, la parall猫le 脿 (AB) passant par M
path parallele(pair A, pair B, pair M){
pair N;
path dte;
N=M+(B-A)/abs(B-A);
dte=droite(M,N);
return dte;
}

//trace des cercles "脿 la main lev茅e"
path cercleML(pair O,pair A){
path c;
c=A{dir(degrees(A-O)+90+eps())}..{dir(degrees(rotate(90,O)*A-O)+90+eps())}rotate(90,O)*A..{dir(degrees(rotate(180,O)*A-O)+90+eps())}rotate(180,O)*A..{dir(degrees(rotate(270,O)*A-O)+90+eps())}rotate(270,O)*A..cycle;
return c;
}

//retourne un cercle de centre O passant par A
path cercle(pair O, pair A){
path c;
if(mainlevee==true){c=cercleML(O,A);} else {c=shift(O)*(scale(abs(O-A))*unitcircle);};
//return shift(O)*(scale(abs(O-A))*unitcircle);
//if(mainlevee=false){return );} else{
//return };
return c;
}
//retourne un cercle de centre O  de rayon R
path cercleR(pair O, real R){
path c;
c=scale(R)*cercle(O,1);
return c;} 
//retourne un cercle de diam猫tre A B
path cercleD(pair A, pair B){
pair O;
path c;
O=milieu(A,B);
c=cercle(O,A);
return c;}
//retourne un arc de cercle de centre B, passant par A et d'un angle entre s et t "autour de A", dans le sens trigo
path Arc(pair C, pair A, real s, real t){
pair M=rotate(s,C)*A;
pair N=rotate(t,C)*A;
return arc(C,z1=M,z2=N);
}

//retourne le projet茅 orthogonal de M sur (AB)
pair projortho(pair M, pair A,pair B){
pair H;
H=extension(M,M+dir(degrees(B-A)+90),A,B);
return H;}

//la hauteur issue de C de ABC
path hauteur(pair C, pair A, pair B){
real c;
pair I;
c=-degrees(C-B)+degrees(A-B)-90;
I=rotate(c,C)*B;
return droite(C,I);
}
//l'orthocentre du triangle ABC
pair orthocentre(pair C, pair A, pair B){
pair I,J,H;
I=rotate(-degrees(C-B)+degrees(A-B)-90,C)*B;
J=rotate(-degrees(A-C)+degrees(B-C)-90,A)*C;
H=extension(C,I,A,J);
return H;
}
//la mediatrice relative 脿 [AB]
path mediatrice(pair A, pair B){
path med;
med=droite(0.5*(A+B),0.5*(A+B)+dir(degrees(B-A)+90));
return med;
}
//le centre du cercle circonscrit 脿 ABC
pair circonscrit(pair C, pair A, pair B){
pair centre;
centre=extension(0.5*(A+B),0.5*(A+B)+dir(degrees(B-A)+90),0.5*(A+C),0.5*(A+C)+dir(degrees(C-A)+90));
return centre;
}
//la bissectrice de ABC
path bissectrice(pair A, pair B, pair C){
path biss;
biss=droite(B,unit(A-B)+unit(C-B)+B);
return biss;
}
// le centre du cercle inscrit 脿 ABC
pair inscrit(pair A, pair B, pair C){
pair centre;
centre=extension(C,C+unit(A-C)+unit(B-C),B,B+unit(C-B)+unit(A-B));
return centre;
}
// Trace du papier millim茅tr茅 dans le cadre
void millimetre(pen sty=orange){
pen p,q;
p=sty*0.8+linewidth(0.5);
q=sty+linewidth(0.1);
for(int i=ceil(xpart(basgauche)*10); i <= floor(xpart(basdroit)*10); i=i+1) draw((i/10,ypart(basdroit))--(i/10,ypart(hautdroit)),q) ;
for(int i=ceil(ypart(basgauche)*10); i <= floor(ypart(hautgauche)*10); i=i+1) draw((xpart(basgauche),i/10)--(xpart(basdroit),i/10),q) ;
for(int i=ceil(xpart(basgauche)); i <= floor(xpart(basdroit)); i=i+1) draw((i,ypart(basdroit))--(i,ypart(hautdroit)),p) ;
for(int i=ceil(ypart(basgauche)); i <= floor(ypart(hautgauche)); i=i+1) draw((xpart(basgauche),i)--(xpart(basdroit),i),p) ;
}
// Trace du papier 脿 carreaux de 0.5 cm de c么t茅 par d茅faut dans le cadre
void carreau(real cote=0.5, pen sty=orange){
pen q;
real nbr=1/cote;
q=sty+linewidth(0.1);
for(int i=ceil(xpart(basgauche)*nbr); i <= floor(xpart(basdroit)*nbr); i=i+1) draw((i/nbr,ypart(basdroit))--(i/nbr,ypart(hautdroit)),q) ;
for(int i=ceil(ypart(basgauche)*nbr); i <= floor(ypart(hautgauche)*nbr); i=i+1) draw((xpart(basgauche),i/nbr)--(xpart(basdroit),i/nbr),q) ;
}
// Trace du papier seyes dans le cadre
void seyes(){
for(int i=ceil(ypart(basgauche)*5); i <= floor(ypart(hautgauche)*5); i=i+1) draw((xpart(basgauche),i/5)--(xpart(basdroit),i/5),lightgreen) ;
for(int i=ceil(xpart(basgauche)*1.25); i <= floor(xpart(basdroit)*1.25); i=i+1) draw((i/1.25,ypart(basdroit))--(i/1.25,ypart(hautdroit)),lightmagenta) ;
for(int i=ceil(ypart(basgauche)*1.25); i <= floor(ypart(hautgauche)*1.25); i=i+1) draw((xpart(basgauche),i/1.25)--(xpart(basdroit),i/1.25),lightmagenta+linewidth(1.5)) ;
}
//trace les axes si graduation=1, gradu茅 toutes les unit茅s, 2 toutes les demi-unit茅s, 3 tous les dixi猫mes;
void axes(repere rep,int graduation=1,pen sty=currentpen){
real epaisseur=0.05;
pair s,u;
path ligne;
pair[] dte;
/////////////// trace l'axe des abscisses
pair A=rep.origine;
pair B=rep.origine+rep.abscisse;
if(xpart(A)==xpart(B)){
s=(ypart(hautgauche)-ypart(B))/(ypart(A)-ypart(B));
u=(ypart(basgauche)-ypart(B))/(ypart(A)-ypart(B));
}
else{
s=(xpart(basdroit)-xpart(B))/(xpart(A)-xpart(B));
u=(xpart(basgauche)-xpart(B))/(xpart(A)-xpart(B));
}
ligne=s*A+(1-s)*B--u*A+(1-u)*B;
dte=intersectionpoints(ligne,cadre);
if((ypart(dte[1])-ypart(dte[0]))*(ypart(B)-ypart(A))>0){
draw(dte[0]--dte[1],sty,Arrow(1.5mm));} else {
draw(dte[1]--dte[0],sty,Arrow(1.5mm));
}
////////////////////////// tracer des graduations
pair n=unit(dir(degrees(B-A)+90))*epaisseur;
for(int i=0;inside(cadre,rep.origine+i*rep.abscisse);i=i+1)
draw(rep.origine+i*rep.abscisse+n--rep.origine+i*rep.abscisse-n,sty);
for(int i=-1;inside(cadre,rep.origine+i*rep.abscisse);i=i-1)
draw(rep.origine+i*rep.abscisse+n--rep.origine+i*rep.abscisse-n,sty);
if(graduation==2){
for(int i=0;inside(cadre,rep.origine+0.5*i*rep.abscisse);i=i+1)
draw(rep.origine+0.5*i*rep.abscisse+n/2--rep.origine+0.5*i*rep.abscisse-n/2,sty);
for(int i=-1;inside(cadre,rep.origine+0.5*i*rep.abscisse);i=i-1)
draw(rep.origine+0.5*i*rep.abscisse+n/2--rep.origine+0.5*i*rep.abscisse-n/2,sty);
} else { if(graduation==3){
for(int i=0;inside(cadre,rep.origine+0.1*i*rep.abscisse);i=i+1)
draw(rep.origine+0.1*i*rep.abscisse+n/2--rep.origine+0.1*i*rep.abscisse-n/2,sty);
for(int i=-1;inside(cadre,rep.origine+0.1*i*rep.abscisse);i=i-1)
draw(rep.origine+0.1*i*rep.abscisse+n/2--rep.origine+0.1*i*rep.abscisse-n/2,sty);
}
}
/////////////// trace l'axe des ordonn茅es
A=rep.origine;
B=rep.origine+rep.ordonnee;
if(xpart(A)==xpart(B)){
s=(ypart(hautgauche)-ypart(B))/(ypart(A)-ypart(B));
u=(ypart(basgauche)-ypart(B))/(ypart(A)-ypart(B));
}
else{
s=(xpart(basdroit)-xpart(B))/(xpart(A)-xpart(B));
u=(xpart(basgauche)-xpart(B))/(xpart(A)-xpart(B));
}
ligne=s*A+(1-s)*B--u*A+(1-u)*B;
dte=intersectionpoints(ligne,cadre);
if((ypart(dte[1])-ypart(dte[0]))*(ypart(B)-ypart(A))>0){
draw(dte[0]--dte[1],sty,Arrow(1.5mm));} else {
draw(dte[1]--dte[0],sty,Arrow(1.5mm));
}
////////////////////////// tracer des graduations
pair n=unit(dir(degrees(B-A)+90))*epaisseur;
for(int i=0;inside(cadre,rep.origine+i*rep.ordonnee);i=i+1)
draw(rep.origine+i*rep.ordonnee+n--rep.origine+i*rep.ordonnee-n,sty);
for(int i=-1;inside(cadre,rep.origine+i*rep.ordonnee);i=i-1)
draw(rep.origine+i*rep.ordonnee+n--rep.origine+i*rep.ordonnee-n,sty);
if(graduation==2){
for(int i=0;inside(cadre,rep.origine+0.5*i*rep.ordonnee);i=i+1)
draw(rep.origine+0.5*i*rep.ordonnee+n/2--rep.origine+0.5*i*rep.ordonnee-n/2,sty);
for(int i=-1;inside(cadre,rep.origine+0.5*i*rep.ordonnee);i=i-1)
draw(rep.origine+0.5*i*rep.ordonnee+n/2--rep.origine+0.5*i*rep.ordonnee-n/2,sty);
} else { if(graduation==3){
for(int i=0;inside(cadre,rep.origine+0.1*i*rep.ordonnee);i=i+1)
draw(rep.origine+0.1*i*rep.ordonnee+n/2--rep.origine+0.1*i*rep.ordonnee-n/2,sty);
for(int i=-1;inside(cadre,rep.origine+0.1*i*rep.ordonnee);i=i-1)
draw(rep.origine+0.1*i*rep.ordonnee+n/2--rep.origine+0.1*i*rep.ordonnee-n/2,sty);
}
}
////////////////////////// tracer du nom de l'origine
label(rep.originetxt,rep.origine,unit(-rep.abscisse-rep.ordonnee));
}

//trace un rep猫re avec les vecteurs de base;
void base(repere rep,bool vecteur=true,pen sty=currentpen){
draw(rep.origine--rep.origine+rep.abscisse,sty+1.2,Arrow(1.5mm));
draw(rep.origine--rep.origine+rep.ordonnee,sty+1.2,Arrow(1.5mm));
if (vecteur==true){
label(rep.abscissetxt,rep.origine+0.5*rep.abscisse,-rep.ordonnee);
label(rep.ordonneetxt,rep.origine+0.5*rep.ordonnee,-rep.abscisse);
}
}
// d茅finit et place un pair avec les coordonn茅es (x;y) dans le rep猫re rep
pair place(string nom,real x, real y,pair direction, repere rep=reperecourant, bool trait=false, pen sty=currentpen){
real epaisseur=croix;
pair n=unit(rep.ordonnee)*epaisseur;
pair m=unit(rep.abscisse)*epaisseur;
label(nom,x*rep.abscisse+y*rep.ordonnee+rep.origine,direction,sty);
pair P=x*rep.abscisse+y*rep.ordonnee+rep.origine;
draw(P+n--P-n,sty);
draw(P+m--P-m,sty);
if (trait==true){
draw(P--(rep.origine+y*rep.ordonnee),linewidth(0.3)+sty+dashed);
draw(P--(rep.origine+x*rep.abscisse),linewidth(0.3)+sty+dashed);
}
return P;
}
// d茅finit un pair avec les coordonn茅es (x;y) dans le rep猫re rep
pair position(real x, real y,repere rep=reperecourant){
pair P;
if(inside(cadre,x*rep.abscisse+y*rep.ordonnee+rep.origine)){
P=x*rep.abscisse+y*rep.ordonnee+rep.origine;} else  {P=rep.origine;}
return P;
}
//trace des fonctions ...
void tracefonction (real f(real),real a, real b,repere rep=reperecourant,int precision=500 ,pen sty=currentpen+linewidth(0.5)){
int n=precision;
real x (int i) {return a+i*(b-a)/n;}
for(int i=0;i<=n;i=i+1){
if(inside(cadre,x(i)*rep.abscisse+f(x(i))*rep.ordonnee+rep.origine)&(inside(cadre,x(i+1)*rep.abscisse+f(x(i+1))*rep.ordonnee+rep.origine))) {
draw(x(i)*rep.abscisse+f(x(i))*rep.ordonnee+rep.origine--x(i+1)*rep.abscisse+f(x(i+1))*rep.ordonnee+rep.origine,sty);}}
}
//trace des courbes param猫tr茅es ...
void tracepara (real f(real),real g(real),real a, real b,repere rep=reperecourant,int precision=500 ,pen sty=currentpen+linewidth(0.5)){
int n=precision;
real t (int i) {return a+i*(b-a)/n;}
for(int i=0;i<=n;i=i+1){
if(inside(cadre,f(t(i))*rep.abscisse+g(t(i))*rep.ordonnee+rep.origine)&(inside(cadre,f(t(i+1))*rep.abscisse+g(t(i+1))*rep.ordonnee+rep.origine))) {
draw(f(t(i))*rep.abscisse+g(t(i))*rep.ordonnee+rep.origine--f(t(i+1))*rep.abscisse+g(t(i+1))*rep.ordonnee+rep.origine,sty);}}
}
//trace des courbes polaires ...
void tracepolaire (real r(real),real a, real b,repere rep=reperecourant,int precision=500 ,pen sty=currentpen+linewidth(0.5)){
int n=precision;
real f(real t){return r(t)*cos(t);}
real g(real t){return r(t)*sin(t);}
tracepara(f,g,a,b,rep,n,sty);
}
//trace la tangente en a 脿 f 
path tangente(real a, real f(real), real h=0.01, repere rep=reperecourant){
real m=(f(a+h)-f(a-h))/(2*h); //le nombre d茅riv茅
return droite(position(a,f(a),rep),position(a,f(a),rep)+rep.abscisse+m*rep.ordonnee);
}
//renvoie un morceau de courbe si tout le trac茅 est contenu dans le cadre ...
path morceau (real f(real),real a, real b,repere rep=reperecourant,int precision=500){
int n=precision;
path C;
real x (int i) {return a+i*(b-a)/n;}
for(int i=0;i<=n;i=i+1){
if(inside(cadre,x(i)*rep.abscisse+f(x(i))*rep.ordonnee+rep.origine)) {
C=C--x(i)*rep.abscisse+f(x(i))*rep.ordonnee+rep.origine;}} // else {C=nullpath;}}
return C;
}

//nomme les fonctions
void nomfonction(string txt, real f(real), real abscisse, repere oij=reperecourant, pair diri, pen p=currentpen){
label(txt,position(abscisse,f(abscisse),oij),diri,p);
}

// renvoie le triangle ABC
path triangle(pair A, pair B, pair C){
path tABC;
//if (mainlevee==false){
//tABC=A--B--C--cycle; } else {
//tABC=A{dir(degrees(B-A)+a)}..{dir(degrees(B-A)+b)}B{dir(degrees(C-B)+c)}..{dir(degrees(C-B)+d)}C{dir(degrees(A-C)+e)}..{dir(degrees(A-C)+f)}A--cycle;
tABC=polygone(A,B,C);
//};
return tABC;
}
//
// renvoie un path, le triangle dont les c么t茅s sont a b et c en cm. 
path triangle3c(pair A, real a, real b, real c, bool dessus=true,real angle=0){
pair B, C,C1;
B=pointdistant(A,c,angle);
C1=compas(A,B,b,a);
if (dessus==false){C=reflect(A,B)*C1;} else{C=C1;};
return triangle(A,B,C);}

// renvoie un path, le triangle de c么t茅 c en cm.et d'angles adjacents alpha et beta  
path triangle1c(pair A, real c, real alpha, real beta, bool dessus=true,real angle=0){
pair B, C,C1;
B=pointdistant(A,c,angle);
C1=extension(A, point_angle_dist(A,B,alpha,1), B, point_angle_dist(B,A,-beta,1));
if (dessus==false){C=reflect(A,B)*C1;} else{C=C1;};
return triangle(A,B,C);}

// renvoie un path, le triangle de c么t茅s adjacents c et b en cm.et formant un angle alpha  
path triangle2c(pair A, real c, real b, real alpha, bool dessus=true,real angle=0){
pair B, C,C1;
B=pointdistant(A,c,angle);
C1=point_angle_dist(A,B,alpha,b);
if (dessus==false){C=reflect(A,B)*C1;} else{C=C1;};
return triangle(A,B,C);}

// renvoie un path, le rectangle de c么t茅s adjacents a et b en cm. Si diagonale=true, b est la diagonale.
path rectangle(pair A, real a, real b,bool diagonale=false,real angle=0){
pair B,C,D,E;
B=pointdistant(A,a,angle);
if(diagonale==false){D=point_angle_dist(A,B,90,b);
C=B-A+D;} else {C=point_angle_dist(A,B,aCos(a/b),b);
D=C+A-B;};
return polygone(A,B,C,D);}

// renvoie un path, le parallelogramme de c么t茅s adjacents a et b en cm formant un angle alpha.
//Si diagonale vaut true, alpha est la diagonale en cm.
path parallelogramme(pair A, real a, real b,real alpha, bool diagonale=false,real angle=0){
pair B,C,D,E;
B=pointdistant(A,a,angle);
if(diagonale==false){D=point_angle_dist(A,B,alpha,b);
C=B-A+D;} else {C=compas(A,B,alpha,b);
D=C+A-B;};
return polygone(A,B,C,D);}

//renvoie un sommet d'un triangle ou un quadrilat猫re
pair sommet(path c,int n){
int p;
if(mainlevee==true){
if(n==0){p=0;} else{p=6*n-2;}; }
else {
if(n==0){p=0;} else{p=2*n-1;};
};
return point(c,p);
}

//definit le type "axe" ie un point et un vecteur directeur qui sera l'unit茅 de graduation
struct axe {
pair origine ;
pair abscisse;
string originetxt="$O$" ;
string abscissetxt="1";
}

//definit l'axe par defaut : origine (0,0) et le vecteur directeur (1,0) 
axe canonique;
canonique.origine=(0,0);
canonique.abscisse=(1,0);
canonique.originetxt="$O$";
canonique.abscissetxt="1";

//definit l'axe courant
axe axecourant=canonique;

 
//les valeurs d茅but et fin en multiple du vecteur unit茅, intermediaire en fraction du vecteur unit茅
void graduation(axe grad=axecourant, real debut, real fin, real intermediaire=0,pen sty=currentpen){
pair origine=grad.origine;
pair unite=grad.abscisse;
pair A,B;
A=origine+unite*debut;
B=origine+unite*fin;
draw(A--B,sty,Arrow(2mm));
for (int i=ceil(debut);i<=floor(fin);i=i+1){
draw(origine+i*unite+0.1*dir(degrees(unite)-90)--origine+i*unite-0.1*dir(degrees(unite)-90));}
if (intermediaire != 0){
for (int i=ceil(debut/intermediaire);i<=floor(fin/intermediaire);i=i+1){
draw(origine+i*unite*intermediaire+0.05*dir(degrees(unite)-90)--origine+i*unite*intermediaire-0.05*dir(degrees(unite)-90));}
}
label(grad.originetxt,origine+0.1*dir(degrees(unite)-90),dir(degrees(unite)-90));
label(grad.abscissetxt,origine+unite+0.1*dir(degrees(unite)-90),dir(degrees(unite)-90));
};

//renvoie un pair qui correspond 脿 une abscisse particuli猫re sur un axe
void abscisse(axe grad=axecourant, string txtdessous, string txtdessus="",real x,bool croix=true,pen sty=currentpen){
pair origine=grad.origine;
pair unite=grad.abscisse;
label(txtdessous,origine+x*unite+0.1*dir(degrees(unite)-90),dir(degrees(unite)-90),sty);
label(txtdessus,origine+x*unite-0.1*dir(degrees(unite)-90),dir(degrees(unite)+90),sty);
if (croix==true){pointe(origine+x*unite,sty);};
};