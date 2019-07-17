A1 = [1,0;0,1;-1,0;0,-1];
b1 = [1;1;1;1];
P1 = polytope(A1,b1);

theta = 0.5;
Rt = [cos(theta), sin(theta);-sin(theta),cos(theta)];
A2 = A1 * Rt;
b2 = [1;1;1;1];
P2 = polytope(A2,b2);

AffA = Rt;
Affb = [1;0];

plot(AffA*P1 + Affb)


