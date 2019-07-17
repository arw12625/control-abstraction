c = 0.01;
p = 11;
A = p/(p+1);

fl = @(x) (x - c)/A;
fh = @(x) (x + c)/A;

x = zeros(1,101);
for i = 1:1000000
    if x(i) >= 0
        x(i+1) = fl(x(i));
    else
        x(i+1) = fh(x(i));
    end
end
length(x) == length(unique(x))