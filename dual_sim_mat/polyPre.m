function [pre_s] = polyPre(A, B, X, U, s)
%polyPre computes the Pre of a polytopic region in a linear system
%   A - transition matrix
%   B - input matrix
%   X - system domain polytope
%   U - input polytope 
%   s - polytope to compute Pre of

Uv = U.V;
polys = Polyhedron(size(Uv,1));

for i = 1:size(Uv,1)
    polys(i) = invAffineMap(s,A,B*Uv(i,:)');
end

pre_s = PolyUnion(polys).convexHull();
pre_s = intersect(pre_s, X);

end

