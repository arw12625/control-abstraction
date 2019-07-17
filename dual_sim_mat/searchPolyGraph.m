function [found] = searchPolyGraph(S, G, searchRoot, R)

found = 0;

visitedNode = zeros(1,G.numnodes);
        evaluatedNode = zeros(1,G.numnodes);
        
        visitedNode(searchRoot) = 1;
        current = searchRoot;
        
        while evaluatedNode(searchRoot) == 0
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
                if R.eq(S(current - 1))
                    found = 1;
                    break;
                end
            end
        end