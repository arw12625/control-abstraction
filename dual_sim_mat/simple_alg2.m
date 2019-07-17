A = [1.15, 0; 0, 1];
B = eye(2);
X = Polyhedron.unitBox(2);

U = Polyhedron('V', [0.1,0; -0.1, 0]);

s1 = Polyhedron.unitBox(2);

S = alg2(A,B,X,U,[s1],9);

close all;
figure()
plot(S);