
c = 0.4;
A = 0.6666;
B = 1;
X = Polyhedron.unitBox(1);
U = c * Polyhedron.unitBox(1);

s1 = Polyhedron('V', [-1; 0]);
s2 = Polyhedron('V', [0; 1]);

S = alg2_tree(A,B,X,U,[s1,s2],100, 0.01);

figure
plot(S);
alpha(0.1);