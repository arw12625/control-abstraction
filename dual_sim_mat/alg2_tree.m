function [S] = alg2_tree(A, B, X, U, S0, maxIter, volTol)
%alg2 Perform the dual simulation algorithm (alg2) on a linear system
%   A - transition matrix
%   B - input matrix
%   X - system domain polytope
%   U - input polytope 
%   S0 - initial polytope partition of X
%   maxIter - maximum number of iterations before prematurely terminating
%   volTol - Volume Tolerance


numPart = length(S0);
S = S0;
G = digraph(ones(1,numPart), 2:(numPart + 1));
partNodes = 2:(numPart + 1);
root = 1;


run = 1;
iter = 1;
newPoly = 1;

t0 = cputime;

while newPoly && iter < maxIter
    newPoly = 0;
    i = 2;
    
    while i <= G.numnodes && iter <= maxIter
        i
        
        R = S(i - 1);
        preR = polyPre(A,B,X,U,R);

        visitedNode = zeros(1,G.numnodes);
        evaluatedNode = zeros(1,G.numnodes);
        current = root;
        
        visitedNode(root) = 1;
        
        while evaluatedNode(root) == 0
            if evaluatedNode(current) == 1
                current = G.predecessors(current);
            elseif visitedNode(current) == 1
                succ = G.successors(current);
                unvisitedSucc = succ(find(visitedNode(succ) == 0, 1));
                if isempty(unvisitedSucc)
                    evaluatedNode(current) = 1;
                else
                    current = unvisitedSucc;
                end
            elseif visitedNode(current) == 0
                visitedNode(current) = 1;
                interR = intersect(preR, S(current - 1));
                if interR.isEmptySet() || interR.eq(S(current - 1))
                    evaluatedNode(current) = 1;
                elseif searchPolyGraph(S,G,root,interR) == 0
                    newPoly = 1;
                    S = [S, interR];
                    visitedNode = [visitedNode,0];
                    evaluatedNode = [evaluatedNode, 0];
                    G = G.addedge(current, length(S) + 1);
                    evaluatedNode(current) = 1;
                end
                    
                    
            end
        end
        


        i = i + 1;
        iter = iter + 1;
    end
    
    run = run + 1;
end

runtime = cputime - t0