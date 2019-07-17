
alpha1 = pi / 5;
A = [cos(alpha1)- 0.1, -sin(alpha1); sin(alpha1), cos(alpha1)];
B = eye(2);
X = Polyhedron.unitBox(2);

%polyshape([1-cos(alpha)+sin(alpha), sin(alpha), 0, -sin(alpha)-(1-cos(alpha)), -sin(alpha), 0],[0, 1-cos(alpha),sin(alpha)+1-cos(alpha),0,cos(alpha)-1,-sin(alpha)-1+cos(alpha)]);
delta = sin(alpha1)+cos(alpha1)-1;
%Uv = [delta, 0, -delta, 0; 0, delta, 0, -delta];
U = Polyhedron('V', [delta, 0; delta/2, delta; -delta, 0; delta/2, -delta]);
U = Polyhedron('V', [0,0]);
U = 0.1 * Polyhedron.unitBox(2);

s1 = Polyhedron('V', [1,-1;1,1;0,1;0,-1]);
s2 = Polyhedron('V', [0,-1;0,1;-1,1;-1,-1]);

%s1 = Polyhedron.unitBox(2);

S = alg2_tree(A,B,X,U,[s1,s2],50, 0.01);

figure
plot(S);
alpha(0.1);

%%

A = [0.5, 1; 0.75, -1];
B = eye(2);
X = Polyhedron.unitBox(2);
U = Polyhedron.unitBox(2);

s1 = Polyhedron('V', [-0.5, -0.5; 0.5, -0.5; 0.5, 0.5; -0.5, 0.5]);
s2 = Polyhedron('V', [-1, -1; -0.5, -1; -0.5, 1; -1, 1]);
s3 = Polyhedron('V', [-0.5, 0.5; 1, 0.5; 1, 1; -0.5, 1]);
s4 = Polyhedron('V', [0.5, -1; 1, -1; 1, 0.5; 0.5, 0.5]);
s5 = Polyhedron('V', [-0.5, -1; 0.5, -1; 0.5, -0.5; -0.5, -0.5]);


S = alg2_tree(A,B,X,U,[s1,s2,s3,s4,s5],40, 0.01);

figure
plot(S);
alpha(0.1);