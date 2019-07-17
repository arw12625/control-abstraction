function [S] = alg2(A, B, X, U, S0, maxIter, volTol)
%alg2 Perform the dual simulation algorithm (alg2) on a linear system
%   A - transition matrix
%   B - input matrix
%   X - system domain polytope
%   U - input polytope 
%   S0 - initial polytope partition of X
%   maxIter - maximum number of iterations before prematurely terminating
%   volTol - Volume Tolerance

S = S0;
newPoly = 1;
i = 1;

    t0 = cputime;
while newPoly == 1 && i < maxIter
    newPoly = 0;
    
    r1 = length(S);
    
    preTime = 0;
    eqTime = 0;
    
    while r1 >= 1 && newPoly == 0
        r2 = length(S);
        while r2 >= 1 && newPoly == 0
            %[r1,r2]
            tPre = cputime;
            
            Rp = polyPre(A,B,S(r2),U,S(r1));
            
            preTime = preTime + (cputime - tPre);

            tEq = cputime;
            
            if ~Rp.isEmptySet() && volume(Rp) > volTol
                
                found = 0;
                for r3 = 1:length(S)
                    if S(r3).eq(Rp)
                        found = 1;
                        break;
                    end
                end
                if ~found
                    newPoly = 1;
                    S(end+1) = Rp;
                end
            end
            
            eqTime = eqTime + (cputime - tEq);
            
            r2 = r2 - 1;
        end
        r1 = r1 - 1;
    end
    
    [i, preTime, eqTime]
    i = i + 1;
end

tEnd = cputime - t0