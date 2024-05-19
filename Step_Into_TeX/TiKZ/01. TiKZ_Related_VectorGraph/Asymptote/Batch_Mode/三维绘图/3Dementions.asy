settings.render=16;
import three;
size(4cm);
draw(-2X--2X,
arrow=Arrow3(emissive(black)));
draw(-2Y--2Y, arrow=Arrow3(emissive(black)));
draw(-2Z--2Z, arrow=Arrow3(emissive(black)));
draw(path3(box((-2,-2),(2,2))), gray);
draw(arc(c=O, Y, Z), blue, arrow = Arrow3(TeXHead2,emissive(blue)));
draw(arc(c=O, -Y, Z), blue, arrow = Arrow3(TeXHead2,emissive(blue)));
draw(arc(c=(1,1,0), Y, 2X, normal=Z), green, arrow =
Arrow3(TeXHead2(normal=Z), emissive(green)));
draw(arc(c=(1,1,0), Y, 2X, normal=-Z), red, arrow =
Arrow3(TeXHead2(normal=Z), emissive(red)));